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


public struct OnboardingView: View, Injectable {

  // MARK: - Property

  public var body: some View {
    ZStack {
      Color.Main.background.ignoresSafeArea()
      LogoView()
      VStack {
        Spacer()
        Button(
          action: {},
          label: {
            HStack {
              Text("Dating App 시작하기")
                .font(.system(size: 16, weight: .bold))
            }
            .foregroundStyle(Color.Main.text)
            .padding()
            .overlay {
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white)
            }
          }
        )
        Spacer().frame(height: 32)
      }
    }
  }

  // MARK: - Init

  public init() {}
}


#Preview {
  OnboardingView()
}
