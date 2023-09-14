//
//  LaunchView.swift
//  Launch
//
//  Created by kim sunchul on 2023/08/09.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import LaunchInterface

public struct LaunchView: View {

  // MARK: - Property

  @StateObject private var viewModel: LaunchViewModel

  @Environment(\.openURL) private var openURL

  public var body: some View {
    ZStack {
      VStack(
        alignment: .center,
        spacing: 24
      ) {
        Image(systemName: "highlighter")
          .resizable()
          .frame(width: 100, height: 100)
        Text("Food Blog Review")
          .font(.system(size: 26, weight: .bold))
      }
      VStack {
        Spacer()
        Text(self.viewModel.completionCount)
          .font(.system(size: 16, weight: .bold))
        Spacer().frame(height: 16)
      }
    }
    .alert(isPresented: self.$viewModel.isPresentAlert) {
      self.makeAlert(self.viewModel.alert)
    }
    .onAppear {
      self.viewModel.runAfterBuild()
    }
    .onDisappear {
      self.viewModel.clearCount()
    }
  }

  // MARK: - Init

  public init(bulider: LaunchWorkerBuildable?) {
    _viewModel = StateObject(wrappedValue: { LaunchViewModel(builder: bulider) }())
  }

  // MARK: - Method

  private func makeAlert(_ alert: LaunchAlert) -> Alert {
    if let secondaryAction = alert.secondaryAction {
      return Alert(
        title: Text(alert.title),
        message: Text(alert.message),
        primaryButton: self.makeButton(alert.primaryAction),
        secondaryButton: self.makeButton(secondaryAction)
      )
    } else {
      return Alert(
        title: Text(alert.title),
        message: Text(alert.message),
        dismissButton: self.makeButton(alert.primaryAction)
      )
    }
  }

  private func makeButton(_ action: LaunchAlert.Action) -> Alert.Button {
    switch action.type {
    case .cancel:
      return .cancel(Text(action.title), action: action.completion)
    case .default:
      return .default(Text(action.title), action: action.completion)
    case .openURL(let url):
      return .default(Text(action.title)) {
        action.completion?()
        self.openURL(url)
      }
    }
  }
}


struct LaunchView_Previews: PreviewProvider {
  
  static var previews: some View {
    return LaunchView(bulider: nil)
  }
}
