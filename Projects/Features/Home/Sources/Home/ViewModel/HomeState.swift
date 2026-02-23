//
//  HomeState.swift
//  Home
//

import Foundation
import Util
import MatchingInterface

struct HomeState {

  // MARK: - Property

  var cards: [MatchingCardItem]

  var isLoading: Bool

  var isEmpty: Bool

  var alert: BaseAlert

  var isPresentAlert: Bool

  // MARK: - Init

  init(
    cards: [MatchingCardItem] = [],
    isLoading: Bool = false,
    isEmpty: Bool = false,
    alert: BaseAlert = .empty,
    isPresentAlert: Bool = false
  ) {
    self.cards = cards
    self.isLoading = isLoading
    self.isEmpty = isEmpty
    self.alert = alert
    self.isPresentAlert = isPresentAlert
  }
}
