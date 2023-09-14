//
//  AlertBuildable.swift
//  Util
//
//  Created by kim sunchul on 2023/09/14.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

public protocol AlertBuildable {

  func buildAlert(_ alert: BaseAlert) -> Alert

  func buildAlertButton(_ action: BaseAlert.Action) -> Alert.Button

  func openURL(url: URL)
}


extension AlertBuildable {

  public func buildAlert(_ alert: BaseAlert) -> Alert {
    if let secondaryAction = alert.secondaryAction {
      return Alert(
        title: Text(alert.title),
        message: Text(alert.message),
        primaryButton: self.buildAlertButton(alert.primaryAction),
        secondaryButton: self.buildAlertButton(secondaryAction)
      )
    } else {
      return Alert(
        title: Text(alert.title),
        message: Text(alert.message),
        dismissButton: self.buildAlertButton(alert.primaryAction)
      )
    }
  }

  public func buildAlertButton(_ action: BaseAlert.Action) -> Alert.Button {
    switch action.type {
    case .cancel:
      return .cancel(Text(action.title), action: action.completion)
    case .default:
      return .default(Text(action.title), action: action.completion)
    case .openURL(let url):
      return .default(Text(action.title)) {
        action.completion?()
        self.openURL(url: url)
      }
    case .destructive:
      return .destructive(Text(action.title), action: action.completion)
    }
  }

  public func openURL(url: URL) { }
}
