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

struct SignupView: View, Injectable {
  
  // MARK: - Property
  
  @ObservedObject
  private var viewModel: SignupViewModel = DIContainer.resolve(
    for: SignupViewModelKey.self
  )
  
  var body: some View {
    VStack(alignment: .leading) {
      BackButton(
        touchPadding: .init(top: 14, leading: 18, bottom: 14, trailing: 18)
      ) {
        self.viewModel.trigger(.previous)
      }
      .accessibilitySortPriority(5)
      VStack(alignment: .leading) {
        self.progressView
        self.currentMainView
        self.nextButton
      }
      .padding(.horizontal, 18)
    }
    .background(.white)
    .alert(isPresented: .constant(self.viewModel.state.isPresentAlert) ) {
      return self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.initUI)
    }
  }
  
  @ViewBuilder
  private var progressView: some View {
    ProgressView(value: self.viewModel.state.progress.value)
      .progressViewStyle(
        SignupProgressViewStyle(
          isAnimation: self.viewModel.state.progress.isAnimation
        )
      )
      .accessibilityLabel("가입 진행률")
      .accessibilitySortPriority(4)
      .disabled(true)
      .padding(.bottom, 24)
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
  private var nextButton: some View {
    SignupNextButton(
      isLoading: self.viewModel.state.bottomButton.isLoading,
      isDisable: self.viewModel.state.bottomButton.isDisable,
      title: "다음"
    ) {
      self.viewModel.trigger(.next)
    }
  }
}


extension SignupView: AlertBuildable { }


#Preview {
  DIContainer.register {
    InjectItem(SignupViewModelKey.self) {
      SignupViewModel(
        mains: [SignupNickname()],
        tokenManager: MockTokenManager()
      )
    }
    InjectItem(SignupRepositoryTypeKey.self) { 
      SignupRepository(networking: .init())
    }
  }
  
  return SignupView()
}
