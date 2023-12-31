//
//  BaseAlert.swift
//  Util
//
//  Created by kim sunchul on 2023/09/14.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public struct BaseAlert {

  // MARK: - Define

  public enum ActionType: Equatable {
    case `default`
    case cancel
    case openURL(url: URL?)
    case destructive
  }

  public struct Action {

    // MARK: - Property

    public let title: String

    public let type: ActionType

    public let completion: (() -> Void)?

    public init(
      title: String,
      type: ActionType,
      completion: (() -> Void)?
    ) {
      self.title = title
      self.type = type
      self.completion = completion
    }
  }

  // MARK: - Property

  public let title: String

  public let message: String

  public let primaryAction: Action

  public let secondaryAction: Action?

  // MARK: - Init

  public init(
    title: String,
    message: String,
    primaryAction: Action = .confirm,
    secondaryAction: Action? = nil
  ) {
    self.title = title
    self.message = message
    self.primaryAction = primaryAction
    self.secondaryAction = secondaryAction
  }
}


extension BaseAlert {

  public static let empty: BaseAlert = .init(
    title: "",
    message: ""
  )

  public static func message(_ message: String) -> BaseAlert {
    return .init(
      title: "",
      message: message,
      primaryAction: .init(
        title: .confirm,
        type: .default,
        completion: {}
      )
    )
  }
}


extension BaseAlert: Equatable {
}


extension BaseAlert.Action {

  public static let confirm: BaseAlert.Action = .init(
    title: .confirm,
    type: .default,
    completion: nil
  )

  public static let cancel: BaseAlert.Action = .init(
    title: .cancel,
    type: .cancel,
    completion: nil
  )
}


extension BaseAlert.Action: Equatable {

  public static func == (lhs: BaseAlert.Action, rhs: BaseAlert.Action) -> Bool {
    return lhs.title == rhs.title && lhs.type == rhs.type
  }
}
