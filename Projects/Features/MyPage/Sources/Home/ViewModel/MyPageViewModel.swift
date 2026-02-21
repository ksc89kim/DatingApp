//
//  MyPageViewModel.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Core
import DI
import AppStateInterface
import MyPageInterface
import UserInterface
import Util

final class MyPageViewModel: ViewModelType, Injectable {

  // MARK: - Define

  private enum TaskKey {
    static let loadProfile = "loadProfileKey"
  }

  // MARK: - Property

  @Published
  var state: MyPageState = .init()

  @Inject(MyPageRepositoryTypeKey.self)
  private var repository: MyPageRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  // MARK: - Method

  func trigger(_ action: MyPageAction) {
    switch action {
    case .loadProfile:
      self.loadProfile()
    case .navigateToEdit:
      self.appState.myPageRouter.append(path: .edit)
    case .navigateToSetting:
      self.appState.myPageRouter.append(path: .setting)
    case .selectImagePage(let index):
      self.state.currentImageIndex = index
    case .dismissAlert:
      self.state.isPresentAlert = false
      self.state.alertMessage = ""
    case .selectCompletionTip:
      self.appState.myPageRouter.append(path: .edit)
    case .purchaseSuperLike, .purchaseBoost, .upgradeSubscription:
      break
    }
  }

  // MARK: - Private

  private func loadProfile() {
    self.taskBag[TaskKey.loadProfile]?.cancel()

    Task { [weak self] in
      await self?.loadProfile()
    }
    .store(in: self.taskBag, for: TaskKey.loadProfile)
  }

  private func loadProfile() async {
    await self.setLoading(true)
    do {
      let response = try await self.repository.fetchMyProfile()
      await self.applyProfile(response)
    } catch {
      await self.handleError(error)
    }
    await self.setLoading(false)
  }

  @MainActor
  private func applyProfile(
    _ response: UserProfileResponse
  ) {
    var newState = self.state
    newState.nickname = response.nickname
    newState.age = UserProfileAgeCalculator
      .calculateAge(from: response.birthday)
    newState.height = response.height
    newState.job = response.job
    newState.profileImageURLs = response.profileImages
    newState.gameGenre = response.gameGenre
    newState.introduce = response.introduce
    newState.mbti = response.mbti
    newState.currentImageIndex = 0
    newState.gameGenreChips = response.gameGenre.map {
      Chip(
        key: $0,
        title: LocalizedStringResource(stringLiteral: $0)
      )
    }
    newState.gameGenreSelections = Set(newState.gameGenreChips)
    self.state = newState
    self.calculateCompletion()
  }

  @MainActor
  private func calculateCompletion() {
    var percentage = 0
    var tips: [ProfileCompletionTip] = []

    for rule in CompletionRule.completionRules {
      let isCompleted = rule.check(self.state)
      if isCompleted { percentage += rule.percentageBoost }
      tips.append(ProfileCompletionTip(
        id: rule.id,
        title: rule.title,
        description: rule.description,
        percentageBoost: rule.percentageBoost,
        sfSymbol: rule.sfSymbol,
        isCompleted: isCompleted
      ))
    }

    self.state.profileCompletionPercentage = percentage
    self.state.completionTips = tips.filter { !$0.isCompleted }
  }

  @MainActor
  private func setLoading(_ isLoading: Bool) {
    self.state.isLoading = isLoading
  }

  @MainActor
  private func handleError(_ error: Error) {
    var newState = self.state
    newState.alertMessage = error.localizedDescription
    newState.isPresentAlert = true
    self.state = newState
  }
}
