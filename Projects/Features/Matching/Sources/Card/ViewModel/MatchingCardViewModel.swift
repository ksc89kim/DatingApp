//
//  MatchingCardViewModel.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation
import Util
import Core
import DI
import MatchingInterface
import AppStateInterface

final class MatchingCardViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  var state: MatchingCardState

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

  func trigger(_ action: MatchingCardAction) {
    Task { [weak self] in
      await self?.trigger(action)
    }
    .store(in: self.taskBag)
  }

  func trigger(_ action: MatchingCardAction) async {
    switch action {
    case .load: await self.load()
    case .like: await self.like()
    case .skip: await self.skip()
    case .swipe(let direction): await self.swipe(direction: direction)
    case .showProfile(let userID): await self.showProfile(userID: userID)
    case .dismissMatchOverlay: await self.dismissMatchOverlay()
    case .sendMessage: await self.sendMessage()
    }
  }

  // MARK: - Private

  private let prefetchThreshold = 3

  private func load() async {
    await MainActor.run {
      self.state.isLoading = true
    }
    do {
      let response = try await self.repository.fetchRecommendations(page: 1)
      await MainActor.run {
        var newState = self.state
        newState.cards = response.recommendations
        newState.currentIndex = 0
        newState.page = 1
        newState.hasMore = response.hasMore
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

  private func loadMore() async {
    guard self.state.hasMore, !self.state.isFetchingMore else { return }
    let nextPage = self.state.page + 1
    await MainActor.run {
      self.state.isFetchingMore = true
    }
    do {
      let response = try await self.repository.fetchRecommendations(page: nextPage)
      await MainActor.run {
        var newState = self.state
        newState.cards.append(contentsOf: response.recommendations)
        newState.page = nextPage
        newState.hasMore = response.hasMore
        newState.isFetchingMore = false
        self.state = newState
      }
    } catch {
      await self.handleError(error)
      await MainActor.run {
        self.state.isFetchingMore = false
      }
    }
  }

  private func like() async {
    guard self.state.currentIndex < self.state.cards.count else { return }
    let card = self.state.cards[self.state.currentIndex]
    do {
      let response = try await self.repository.like(userID: card.userID)
      await MainActor.run {
        self.removeCurrentCard()
        if response.isMatched {
          var newState = self.state
          newState.matchedUser = card
          newState.isShowingMatchOverlay = true
          self.state = newState
        }
      }
      await self.prefetchIfNeeded()
    } catch {
      await self.handleError(error)
    }
  }

  private func skip() async {
    guard self.state.currentIndex < self.state.cards.count else { return }
    let card = self.state.cards[self.state.currentIndex]
    do {
      try await self.repository.skip(userID: card.userID)
      await MainActor.run {
        self.removeCurrentCard()
      }
      await self.prefetchIfNeeded()
    } catch {
      await self.handleError(error)
    }
  }

  private func prefetchIfNeeded() async {
    guard self.state.cards.count <= self.prefetchThreshold else { return }
    await self.loadMore()
  }

  private func swipe(direction: SwipeDirection) async {
    switch direction {
    case .right: await self.like()
    case .left: await self.skip()
    }
  }

  @MainActor
  private func showProfile(userID: String) {
    self.appState.matchingRouter.append(
      path: .userProfile(userID: userID)
    )
  }

  @MainActor
  private func dismissMatchOverlay() {
    var newState = self.state
    newState.isShowingMatchOverlay = false
    newState.matchedUser = nil
    self.state = newState
  }

  @MainActor
  private func sendMessage() {
    guard let matchedUser = self.state.matchedUser else { return }
    var newState = self.state
    newState.isShowingMatchOverlay = false
    newState.matchedUser = nil
    self.state = newState
    self.appState.chatRouter.append(
      path: .chatRoom(idx: matchedUser.userID)
    )
  }

  @MainActor
  private func removeCurrentCard() {
    var newState = self.state
    if newState.currentIndex < newState.cards.count {
      newState.cards.remove(at: newState.currentIndex)
    }
    newState.isEmpty = newState.cards.isEmpty
    self.state = newState
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
