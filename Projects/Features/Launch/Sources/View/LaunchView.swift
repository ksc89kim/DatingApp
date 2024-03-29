//
//  LaunchView.swift
//  Launch
//
//  Created by kim sunchul on 2023/08/09.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import DI
import Util
import Core
import LaunchInterface
import AppStateInterface

struct LaunchView: View, Injectable {

  // MARK: - Property

  @ObservedObject
  private var viewModel: LaunchViewModel = DIContainer.resolve(
    for: LaunchViewModelKey.self
  )

  @Environment(\.scenePhase) var scenePhase

  @Environment(\.openURL) private var openURL

  @State private var animate = false

  var body: some View {
    ZStack {
      UtilAsset.MainColor.background.swiftUIColor.ignoresSafeArea()
      LogoView(animate: self.$animate)
      VStack {
        Spacer()
        Text(self.viewModel.state.bottomMessage)
          .systemScaledFont(font: .bold, size: 16)
          .foregroundStyle(UtilAsset.MainColor.text.swiftUIColor)
        Spacer().frame(height: 16)
      }
    }
    .background()
    .alert(isPresented: .constant(self.viewModel.state.isPresentAlert)) {
      return self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.runAfterBuildForWoker)
      self.animate = true
    }
    .onDisappear {
      self.viewModel.trigger(.clearCount)
    }
    .onChange(of: self.scenePhase) { _, newValue in
      if newValue == .active {
        self.viewModel.trigger(.checkForceUpdate)
      }
    }
  }
}


extension LaunchView: AlertBuildable {

  func openURL(url: URL?) {
    guard let url = url else { return }
    self.openURL(url)
  }
}


#Preview {
  AppStateDIRegister.register()
  
  DIContainer.register {
    InjectItem(LaunchWorkerBuilderKey.self) { nil }
    InjectItem(LaunchViewModelKey.self) { LaunchViewModel(tokenManager: MockTokenManager()) }
  }
  return LaunchView()
}
