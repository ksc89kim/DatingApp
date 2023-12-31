//
//  OnboardingViewModel.swift
//  Onboarding
//
//  Created by kim sunchul on 11/16/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI
import AppStateInterface

final class OnboardingViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  var state: OnboardingState = .init()

  @Inject(AppStateKey.self)
  private var appState: AppState

  // MARK: - Method

  func trigger(_ action: OnboardingAction) {
    switch action {
    case .presentSignup: self.presentSignup()
    }
  }

  private func presentSignup() {
    self.appState.entranceRouter.append(path: .signup)
  }
}
