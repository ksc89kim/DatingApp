//
//  NaivigationTransition+Define.swift
//  Util
//
//  Created by kim sunchul on 11/17/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import NavigationTransitions
import SwiftUI

public enum NavigationTransition {
  case base
  case slide
  case fadeCross
  
  @inlinable
  public static var `default`: Self {
    return .base
  }
  
  var asNavigationTransition: AnyNavigationTransition {
    switch self {
    case .base: return .default
    case .slide: return .slide
    case .fadeCross: return .fade(.cross).animation(.none)
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
    _ transition: NavigationTransition,
    interactivity: Interactivity = .default
  ) -> some View {
    return self.navigationTransition(
      transition.asNavigationTransition,
      interactivity: interactivity.asNavigationInteractivity
    )
  }
}
