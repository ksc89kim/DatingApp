//
//  NaivigationTransition+Define.swift
//  Util
//
//  Created by kim sunchul on 11/17/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUINavigationTransitions
import SwiftUI

public enum NavigationTransitionType {
  case base
  case slide
  case fadeCross
  case slideUp
  
  @inlinable
  public static var `default`: Self {
    return .base
  }
  
  var asNavigationTransition: AnyNavigationTransition {
    switch self {
    case .base: return .default
    case .slide: return .slide
    case .fadeCross: return .fade(.cross).animation(.none)
    case .slideUp:
      return .init(SlideUpTransition())
        .animation(
          .interpolatingSpring(mass: 1.0, stiffness: 300, damping: 25)
        )
    }
  }
}


public enum Interactivity {
  case disabled
  case edgePan
  case pan
  
  @inlinable
  public static var `default`: Self {
    .edgePan
  }
  
  var asNavigationInteractivity: AnyNavigationTransition.Interactivity {
    switch self {
    case .disabled: return .disabled
    case .edgePan: return .edgePan
    case .pan: return .pan
    }
  }
}


extension View {
  @MainActor
  public func navigationTransition(
    _ transition: NavigationTransitionType,
    interactivity: Interactivity = .default
  ) -> some View {
    return self.navigationTransition(
      transition.asNavigationTransition,
      interactivity: interactivity.asNavigationInteractivity
    )
  }
}
