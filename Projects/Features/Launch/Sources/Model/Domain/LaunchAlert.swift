//
//  LaunchAlert.swift
//  Launch
//
//  Created by kim sunchul on 2023/09/13.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

struct LaunchAlert {

  // MARK: - Define

  enum ActionType: Equatable {
    case `default`
    case cancel
    case openURL(url: URL)
  }

  struct Action {

    // MARK: - Property
    
    let title: String

    let type: ActionType

    let completion: (() -> Void)?
  }

  // MARK: - Property

  let title: String

  let message: String

  let primaryAction: Action

  let secondaryAction: Action? = nil

  static let empty: LaunchAlert = .init(
    title: "",
    message: "",
    primaryAction: .init(
      title: "",
      type: .default,
      completion: nil
    )
  )
}
