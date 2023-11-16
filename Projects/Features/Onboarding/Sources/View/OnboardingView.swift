//
//  OnboardingView.swift
//  OnboardingInterface
//
//  Created by kim sunchul on 11/8/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import DI
import OnboardingInterface

public struct OnboardingView: View, Injectable {

  @StateObject private var viewModel: OnboardingViewModel = DIContainer.resolve(
    for: OnboardingViewModelKey.self
  )

  // MARK: - Property

  public var body: some View {
    ZStack {
      Color.Main.background.ignoresSafeArea()
      LogoView()
      VStack {
        Spacer()
        Button(
          action: { self.viewModel.trigger(.presentSignup) },
          label: {
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.white)
              .frame(
                maxWidth: .infinity,
                maxHeight: 48
              )
              .overlay {
                Text("Dating App 시작하기")
                  .font(.system(size: 16, weight: .bold))
                  .foregroundStyle(Color.Main.text)
              }
          }
        )
        .buttonStyle(PressedButtonStyle())
        .padding(.horizontal, 24)
        Spacer()
          .frame(height: 32)
      }
    }
  }

  // MARK: - Init

  public init() {}
}


#Preview {
  DIContainer.register {
    InjectItem(OnboardingViewModelKey.self) {
      OnboardingViewModel()
    }
  }
  return OnboardingView()
}
