//
//  LaunchView.swift
//  Launch
//
//  Created by kim sunchul on 2023/08/09.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import LaunchInterface
import DI
import Util

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
        Text(self.viewModel.state.completionCountMessage)
          .font(.system(size: 16, weight: .bold))
        Spacer().frame(height: 16)
      }
    }
    .alert(isPresented: Binding(
      get: { self.viewModel.state.isPresentAlert },
      set: { _ in }
    )) {
      return self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.runAfterBuildForWoker)
    }
    .onDisappear {
      self.viewModel.trigger(.clearCount)
    }
  }

  // MARK: - Init

  public init(bulider: LaunchWorkerBuildable?) {
    _viewModel = StateObject(wrappedValue: { LaunchViewModel(builder: bulider) }())
  }
}


extension LaunchView: AlertBuildable {

  public func openURL(url: URL) {
    self.openURL(url)
  }
}


struct LaunchView_Previews: PreviewProvider {
  
  static var previews: some View {
    return LaunchView(bulider: nil)
  }
}
