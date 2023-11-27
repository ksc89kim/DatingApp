//
//  OnboardingDIRegister.swift
//  Onboarding
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import OnboardingInterface
import DI

public struct OnboardingDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(OnboardingViewModelKey.self) { OnboardingViewModel() }
      InjectItem(OnboardingViewKey.self) { OnboardingView() }
    }
  }
}
