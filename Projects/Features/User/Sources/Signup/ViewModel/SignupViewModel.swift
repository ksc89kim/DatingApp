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

  // MARK: - Define

  enum TextConstant {
    static let confirm = "확인"
  }

  // MARK: - Property

  @Published
  public var state: SignupState = .init()

  @Inject(AppStateKey.self)
  private var appState: AppState

  @Inject(SignupRepositoryTypeKey.self)
  private var signupRepository: SignupRepositoryType

  @Inject(LoginKey.self)
  private var login: Loginable

  private var tokenManager: TokenManagerType

  private var index: Int

  private let mains: [SignupMain]

  private let taskBag: AnyCancelTaskBag = .init()

  // MARK: - Init

  public init(
    mains: [SignupMain] = [
      SignupNickname()
    ],
    index: Int = 0,
    tokenManager: TokenManagerType
  ) {
    self.mains = mains
    defer {
      self.mains.forEach { main in
        var main = main
        main.repository = self.signupRepository
      }
    }
    self.index = index
    self.tokenManager = tokenManager
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
    guard self.mains.indices ~= self.index + 1 else {
      self.complete()
      return
    }
    self.state.currentMain?.complete()
    self.index += 1
    self.state.progress.isAnimation = true
    self.updateMainViewTypeIfNeeded()
  }

  private func previous() {
    guard self.mains.indices ~= self.index - 1 else {
      _ = self.appState.router.main.popLast()
      return
    }
    self.index -= 1
    self.state.progress.isAnimation = true
    self.updateMainViewTypeIfNeeded()
  }

  private func updateMainViewTypeIfNeeded() {
    guard self.mains.indices ~= self.index else { return }
    self.state.currentMain = self.mains[self.index]
    self.state.progress.value = Double(self.index + 1) / Double(self.mains.count)
    self.state.bottomButton.isDisable = self.mains[self.index].isBottomDisable
  }

  private func updateNicknameIfNeeded(_ nickname: String) {
    guard let signupNickname = self.state.currentMain as? SignupNickname else {
      return
    }
    signupNickname.updateNickname(nickname: nickname)
    self.state.bottomButton.isDisable = signupNickname.isBottomDisable
  }

  private func complete() {
    self.startLoading()

    Task { [weak self] in
      do {
        try await self?.requestSignup()
        try await self?.requestLogin()
        await self?.successSignup()
      } catch {
        await self?.handleError(error)
      }
    }
    .store(in: self.taskBag)
  }

  private func requestSignup() async throws {
    let request = self.mains.reduce(SignupRequest()) { partialResult, main in
      return main.mergeRequest(partialResult)
    }

    let entity = try await self.signupRepository.signup(request: request)
    self.tokenManager.save(token: entity.token)
  }

  private func requestLogin() async throws {
    try await self.login.login()
  }

  @MainActor
  private func handleError(_ error: Error) {
    self.state.alert = .init(
      title: "",
      message: error.localizedDescription,
      primaryAction: .init(
        title: TextConstant.confirm,
        type: .default,
        completion: { [weak self] in
          self?.endLoading()
        }
      )
    )
    self.state.isPresentAlert = true
  }

  @MainActor
  private func successSignup() {
    self.appState.router.main.removeAll()
    self.endLoading()
    self.state.successSignup = true
  }

  private func startLoading() {
    self.state.bottomButton.isLoading = true
    self.state.bottomButton.isDisable = true
  }

  private func endLoading() {
    self.state.bottomButton.isLoading = false
    self.state.bottomButton.isDisable = false
  }
}
