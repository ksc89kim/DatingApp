//
//  MatchingCardAction.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation

enum MatchingCardAction {
  case load
  case like
  case skip
  case swipe(direction: SwipeDirection)
  case showProfile(userID: String)
  case dismissMatchOverlay
  case sendMessage
}


enum SwipeDirection {
  case left
  case right
}
