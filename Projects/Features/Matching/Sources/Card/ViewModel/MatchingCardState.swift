//
//  MatchingCardState.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation
import Util
import MatchingInterface

struct MatchingCardState {

  // MARK: - Property

  var cards: [MatchingCardItem]

  var currentIndex: Int

  var page: Int

  var hasMore: Bool

  var isLoading: Bool

  var isFetchingMore: Bool

  var isEmpty: Bool

  var matchedUser: MatchingCardItem?

  var isShowingMatchOverlay: Bool

  var alert: BaseAlert

  var isPresentAlert: Bool

  // MARK: - Init

  init(
    cards: [MatchingCardItem] = [],
    currentIndex: Int = 0,
    page: Int = 1,
    hasMore: Bool = true,
    isLoading: Bool = false,
    isFetchingMore: Bool = false,
    isEmpty: Bool = false,
    matchedUser: MatchingCardItem? = nil,
    isShowingMatchOverlay: Bool = false,
    alert: BaseAlert = .empty,
    isPresentAlert: Bool = false
  ) {
    self.cards = cards
    self.currentIndex = currentIndex
    self.page = page
    self.hasMore = hasMore
    self.isLoading = isLoading
    self.isFetchingMore = isFetchingMore
    self.isEmpty = isEmpty
    self.matchedUser = matchedUser
    self.isShowingMatchOverlay = isShowingMatchOverlay
    self.alert = alert
    self.isPresentAlert = isPresentAlert
  }
}
