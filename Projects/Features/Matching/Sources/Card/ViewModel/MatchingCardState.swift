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

  var isLoading: Bool

  var isEmpty: Bool

  var matchedUser: MatchingCardItem?

  var isShowingMatchOverlay: Bool

  var alert: BaseAlert

  var isPresentAlert: Bool

  // MARK: - Init

  init(
    cards: [MatchingCardItem] = [],
    currentIndex: Int = 0,
    isLoading: Bool = false,
    isEmpty: Bool = false,
    matchedUser: MatchingCardItem? = nil,
    isShowingMatchOverlay: Bool = false,
    alert: BaseAlert = .empty,
    isPresentAlert: Bool = false
  ) {
    self.cards = cards
    self.currentIndex = currentIndex
    self.isLoading = isLoading
    self.isEmpty = isEmpty
    self.matchedUser = matchedUser
    self.isShowingMatchOverlay = isShowingMatchOverlay
    self.alert = alert
    self.isPresentAlert = isPresentAlert
  }
}
