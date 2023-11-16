//
//  Onboarding+InjectionKey.swift
//  OnboardingInterface
//
//  Created by kim sunchul on 11/8/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//
import SwiftUI
import DI
import Core

public enum OnboardingViewKey: InjectionKey {
  public typealias Value = View
}


public enum OnboardingViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}
