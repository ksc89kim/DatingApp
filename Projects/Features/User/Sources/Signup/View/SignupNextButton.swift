//
//  SignupNextButton.swift
//  User
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct SignupNextButton: View {
  
  // MARK: - Property
  
  let isLoading: Bool
  
  let isDisable: Bool
  
  let title: LocalizedStringResource
  
  let nextAction: () -> Void
  
  var body: some View {
    Button(
      action: self.nextAction,
      label: {
        RoundedRectangle(cornerRadius: 12)
          .frame(maxWidth: .infinity, maxHeight: 48)
          .foregroundColor(UtilAsset.MainColor.background.swiftUIColor)
          .overlay {
            if self.isLoading {
              ProgressView()
                .tint(Color.white)
            } else {
              Text(self.title)
                .systemScaledFont(style: .bottomButton)
                .foregroundStyle(UtilAsset.MainColor.text.swiftUIColor)
            }
          }
      }
    )
    .buttonStyle(PressedButtonStyle())
    .disabled(self.isDisable)
    .opacity(self.isDisable ? 0.7 : 1.0)
    .padding(.vertical, 18)
  }
}


#Preview {
  SignupNextButton(
    isLoading: false,
    isDisable: false,
    title: "다음",
    nextAction: {}
  )
}
