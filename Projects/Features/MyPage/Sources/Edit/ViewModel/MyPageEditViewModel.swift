//
//  MyPageEditViewModel.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Core
import DI
import MyPageInterface
import Util

final class MyPageEditViewModel: ViewModelType, Injectable {

  // MARK: - Define

  private enum TaskKey {
    static let save = "saveKey"
  }

  // MARK: - Property

  @Published
  var state: MyPageEditState = .init()

  @Inject(MyPageRepositoryTypeKey.self)
  private var repository: MyPageRepositoryType

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  var onSaveSuccess: (() -> Void)?

  // MARK: - Init

  init(input: MyPageEditInput = .init()) {
    let allChips = ProfileOptions.allGameGenres.map {
      Chip(
        key: $0,
        title: LocalizedStringResource(
          stringLiteral: $0
        )
      )
    }
    let selectedChips = allChips.filter {
      guard let key = $0.key else { return false }
      return input.gameGenre.contains(key)
    }
    self.state = MyPageEditState(
      nickname: input.nickname,
      introduce: input.introduce,
      height: input.height,
      job: input.job,
      gameGenre: input.gameGenre,
      mbti: input.mbti,
      availableGenreChips: allChips,
      selectedGenreChips: Set(selectedChips)
    )
  }

  // MARK: - Method

  func trigger(_ action: MyPageEditAction) {
    switch action {
    case let .load(input):
      self.loadState(input: input)
    case .updateNickname(let value):
      self.state.nickname = value
    case .updateIntroduce(let value):
      self.state.introduce = String(
        value.prefix(140)
      )
    case .updateHeight(let value):
      self.state.height = value
    case .updateJob(let value):
      self.state.job = value
    case .updateSelectedGenres(let chips):
      self.state.selectedGenreChips = chips
    case .updateMbti(let value):
      self.state.mbti = value
    case .save:
      self.save()
    case .dismiss:
      break
    case .dismissAlert:
      self.state.isPresentAlert = false
      self.state.alertMessage = ""
    }
  }

  // MARK: - Private

  private func loadState(input: MyPageEditInput) {
    let allChips = ProfileOptions.allGameGenres.map {
      Chip(
        key: $0,
        title: LocalizedStringResource(
          stringLiteral: $0
        )
      )
    }
    let selectedChips = allChips.filter {
      guard let key = $0.key else { return false }
      return input.gameGenre.contains(key)
    }
    var newState = self.state
    newState.nickname = input.nickname
    newState.introduce = input.introduce
    newState.height = input.height
    newState.job = input.job
    newState.gameGenre = input.gameGenre
    newState.mbti = input.mbti
    newState.availableGenreChips = allChips
    newState.selectedGenreChips = Set(selectedChips)
    self.state = newState
  }

  private func save() {
    self.taskBag[TaskKey.save]?.cancel()

    Task { [weak self] in
      await self?.save()
    }
    .store(in: self.taskBag, for: TaskKey.save)
  }

  private func save() async {
    await self.setSaving(true)
    do {
      let genreStrings = self.state
        .selectedGenreChips
        .compactMap(\.key)
      
      let request = MyPageUpdateRequest(
        nickname: self.state.nickname,
        introduce: self.state.introduce,
        height: self.state.height,
        job: self.state.job,
        gameGenre: genreStrings,
        mbti: self.state.mbti
      )
      _ = try await self.repository
        .updateMyProfile(request)
      await MainActor.run {
        self.onSaveSuccess?()
      }
    } catch {
      await self.handleError(error)
    }
    await self.setSaving(false)
  }

  @MainActor
  private func setSaving(_ isSaving: Bool) {
    self.state.isSaving = isSaving
  }

  @MainActor
  private func handleError(_ error: Error) {
    var newState = self.state
    newState.alertMessage = error.localizedDescription
    newState.isPresentAlert = true
    self.state = newState
  }
}
