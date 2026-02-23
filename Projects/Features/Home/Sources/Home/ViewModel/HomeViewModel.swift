//
//  HomeViewModel.swift
//  Home
//

import Foundation
import Util
import Core
import DI
import MatchingInterface
import AppStateInterface

final class HomeViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  var state: HomeState

  @Inject(MatchingRepositoryTypeKey.self)
  private var repository: MatchingRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  private let taskBag: AnyCancelTaskBag = .init()

  // MARK: - Init

  init() {
    self.state = .init()
  }

  // MARK: - Method

  func trigger(_ action: HomeAction) {
    Task { [weak self] in
      await self?.trigger(action)
    }
    .store(in: self.taskBag)
  }

  func trigger(_ action: HomeAction) async {
    switch action {
    case .load: await self.load()
    case .refresh: await self.refresh()
    case .showProfile(let userID): await self.showProfile(userID: userID)
    }
  }

  // MARK: - Private

  private func load() async {
    await MainActor.run {
      self.state.isLoading = true
    }
    do {
      let response = try await self.repository.fetchRecommendations(page: 1)
      await MainActor.run {
        var newState = self.state
        newState.cards = response.recommendations
        newState.isEmpty = response.recommendations.isEmpty
        newState.isLoading = false
        self.state = newState
      }
    } catch {
      await self.handleError(error)
      await MainActor.run {
        self.state.isLoading = false
      }
    }
  }

  private func refresh() async {
    await self.load()
  }

  @MainActor
  private func showProfile(userID: String) {
    self.appState.homeRouter.append(path: .userProfile(userID: userID))
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
