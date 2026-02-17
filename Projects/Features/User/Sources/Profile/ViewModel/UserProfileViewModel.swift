//
//  UserProfileViewModel.swift
//  User
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import Util
import Core
import DI
import UserInterface
import AppStateInterface

public final class UserProfileViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  public var state: UserProfileState

  @Inject(UserProfileRepositoryTypeKey.self)
  private var repository: UserProfileRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  private let userID: String

  private let taskBag: AnyCancelTaskBag = .init()

  // MARK: - Init

  public init(userID: String, entryType: UserProfileEntryType) {
    self.userID = userID
    self.state = .init(entryType: entryType)
  }

  // MARK: - Method

  public func trigger(_ action: UserProfileAction) {
    Task { [weak self] in
      await self?.trigger(action)
    }
    .store(in: self.taskBag)
  }

  public func trigger(_ action: UserProfileAction) async {
    switch action {
    case .loadProfile: await self.loadProfile()
    case .swipeImage(let index): self.swipeImage(index: index)
    case .like: await self.like()
    case .skip: await self.skip()
    case .back: await self.back()
    case .report: await self.report()
    case .block: await self.block()
    case .openChat: await self.openChat()
    case .showMoreMenu(let isShowing):
      self.state.isShowingMoreMenu = isShowing
    case .dismissAlert:
      self.state.isPresentAlert = false
    }
  }

  // MARK: - Private

  private func loadProfile() async {
    self.taskBag.cancel()
    await MainActor.run {
      var newState = self.state
      newState.isLoading = true
      newState.errorMessage = nil
      self.state = newState
    }
    do {
      let response = try await self.repository.fetchProfile(
        userID: self.userID
      )
      await self.applyProfile(response)
    } catch {
      await self.handleLoadError(error)
    }
    await MainActor.run {
      self.state.isLoading = false
    }
  }

  @MainActor
  private func applyProfile(_ response: UserProfileResponse) {
    var newState = self.state
    newState.nickname = response.nickname
    newState.age = UserProfileAgeCalculator.calculateAge(
      from: response.birthday
    )
    newState.height = response.height
    newState.job = response.job
    newState.profileImageURLs = response.profileImages.compactMap {
      URL(string: $0)
    }
    let chips = response.gameGenre.map { genre in
      Chip(
        key: genre,
        title: .init(stringLiteral: genre)
      )
    }
    newState.gameGenreChips = chips
    newState.gameGenreSelections = Set(chips)
    newState.introduce = response.introduce
    newState.mbti = response.mbti
    self.state = newState
  }

  private func swipeImage(index: Int) {
    self.state.currentImageIndex = index
  }

  private func like() async {
    do {
      try await self.repository.like(userID: self.userID)
      await MainActor.run {
        var newState = self.state
        newState.didLike = true
        newState.shouldDismiss = true
        self.state = newState
      }
    } catch {
      await self.handleError(error)
    }
  }

  private func skip() async {
    do {
      try await self.repository.skip(userID: self.userID)
      await MainActor.run {
        var newState = self.state
        newState.didSkip = true
        newState.shouldDismiss = true
        self.state = newState
      }
    } catch {
      await self.handleError(error)
    }
  }

  private func report() async {
    do {
      try await self.repository.report(userID: self.userID)
      await MainActor.run {
        var newState = self.state
        newState.didReport = true
        newState.shouldDismiss = true
        self.state = newState
      }
    } catch {
      await self.handleError(error)
    }
  }

  private func block() async {
    do {
      try await self.repository.block(userID: self.userID)
      await MainActor.run {
        var newState = self.state
        newState.didBlock = true
        newState.shouldDismiss = true
        self.state = newState
      }
    } catch {
      await self.handleError(error)
    }
  }

  @MainActor
  private func openChat() {
    self.appState.chatRouter.append(
      path: .chatRoom(idx: self.userID)
    )
    self.state.shouldDismiss = true
  }

  @MainActor
  private func back() {
    self.state.shouldDismiss = true
  }

  @MainActor
  private func handleLoadError(_ error: Error) {
    self.state.errorMessage = error.localizedDescription
  }

  @MainActor
  private func handleError(_ error: Error) {
    var newState = self.state
    newState.alert = .init(
      title: "",
      message: error.localizedDescription,
      primaryAction: .init(
        title: .confirm,
        type: .default,
        completion: nil
      )
    )
    newState.isPresentAlert = true
    self.state = newState
  }
}
