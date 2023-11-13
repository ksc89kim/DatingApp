//
//  SignupViewModel.swift
//  User
//
//  Created by kim sunchul on 11/11/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Core
import DI
import UserInterface
import AppStateInterface

public final class SignupViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published 
  public var state: SignupState = .init()

  @Inject(AppStateKey.self)
  private var appState: AppState

  private var index: Int

  private let mains: [SignupMain]

  // MARK: - Init

  public init(
    mains: [SignupMain] = [
      SignupNickname()
    ],
    index: Int = 0
  ) {
    self.mains = mains
    self.index = index
  }

  // MARK: - Method

  public func trigger(_ action: SignupAction) {
    switch action {
    case .initUI: self.initUI()
    case .nickname(let nickname): self.updateNicknameIfNeeded(nickname)
    case .next: self.next()
    case .previous: self.previous()
    }
  }

  private func initUI() {
    self.index = 0
    self.updateMainViewTypeIfNeeded()
  }

  private func next() {
    guard self.mains.indices ~= self.index + 1 else { return }
    self.index += 1
    self.state.isProgressViewAnimation = true
    self.updateMainViewTypeIfNeeded()
  }

  private func previous() {
    guard self.mains.indices ~= self.index - 1 else { return }
    self.index -= 1
    self.state.isProgressViewAnimation = true
    self.updateMainViewTypeIfNeeded()
  }

  private func updateMainViewTypeIfNeeded() {
    guard self.mains.indices ~= self.index else { return }
    self.state.currentMain = self.mains[self.index]
    self.state.progressValue = Double(self.index + 1) / Double(self.mains.count)
    self.state.isBottmButtonDisable = self.mains[self.index].isBottomDisable
  }

  private func updateNicknameIfNeeded(_ nickname: String) {
    guard let signupNickname = self.state.currentMain as? SignupNickname else {
      return
    }
    signupNickname.updateNickname(nickname: nickname)
    self.state.isBottmButtonDisable = signupNickname.isBottomDisable
  }
}
