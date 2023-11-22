//
//  SignupView.swift
//  UserInterface
//
//  Created by kim sunchul on 11/9/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import DI
import Core
import UserInterface
import AppStateInterface

public struct SignupView: View, Injectable {

  // MARK: - Property

  @StateObject
  private var viewModel: SignupViewModel = DIContainer.resolve(
    for: SignupViewModelKey.self
  )

  public var body: some View {
    VStack(alignment: .leading) {
      self.backButton
      self.progressView
      self.currentMainView
      self.nextButton
    }
    .padding(.horizontal, 18)
    .alert(isPresented: self.$viewModel.state.isPresentAlert) {
      return self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.initUI)
    }
  }

  @ViewBuilder
  private var currentMainView: some View {
    if let main = self.viewModel.state.currentMain {
      switch main {
      case let signupNickname as SignupNickname:
        let binding: Binding<String> = .init(
          get: { signupNickname.nickname },
          set: { nickname in
            self.viewModel.trigger(.nickname(nickname))
          }
        )
        SignupInputNicknameView(
          nickname: binding,
          limitCount: signupNickname.limitCount
        )
        .transition(.opacity)
      default: Spacer()
      }
    } else {
      Spacer()
    }
  }

  @ViewBuilder
  private var backButton: some View {
    Button(
      action: { self.viewModel.trigger(.previous) },
      label: {
        Image(systemName: "chevron.backward")
          .resizable()
          .frame(width: 10, height: 18)
          .foregroundColor(UtilAsset.MainColor.background.swiftUIColor)
      }
    )
  }

  @ViewBuilder
  private var progressView: some View {
    ProgressView(value: self.viewModel.state.progress.value)
      .progressViewStyle(
        SignupProgressViewStyle(
          isAnimation: self.viewModel.state.progress.isAnimation
        )
      )
      .padding(.top, 24)
      .padding(.bottom, 34)
  }

  @ViewBuilder
  private var nextButton: some View {
    Button(
      action: {
        self.viewModel.trigger(.next)
      },
      label: {
        RoundedRectangle(cornerRadius: 12)
          .frame(maxWidth: .infinity, maxHeight: 48)
          .foregroundColor(UtilAsset.MainColor.background.swiftUIColor)
          .overlay {
            if self.viewModel.state.bottomButton.isLoading {
              ProgressView()
                .tint(Color.white)
            } else {
              Text("다음")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(UtilAsset.MainColor.text.swiftUIColor)
            }
          }
      }
    )
    .buttonStyle(PressedButtonStyle())
    .disabled(self.viewModel.state.bottomButton.isDisable)
    .opacity(self.viewModel.state.bottomButton.isDisable ? 0.7 : 1.0)
    .padding(.vertical, 18)
  }

  // MARK: - Init

  public init() {}
}


extension SignupView: AlertBuildable { }


#Preview {
  DIContainer.register {
    InjectItem(SignupViewModelKey.self) {
      SignupViewModel(tokenManager: MockTokenManager())
    }
    InjectItem(SignupRepositoryTypeKey.self) { SignupRepository(networking: .init())
    }
  }
  
  return SignupView()
}
