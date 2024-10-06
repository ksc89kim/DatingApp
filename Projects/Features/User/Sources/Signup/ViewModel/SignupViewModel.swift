//
//  SignupViewModel.swift
//  User
//
//  Created by kim sunchul on 11/11/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import Util
import Core
import DI
import UserInterface
import AppStateInterface

final class SignupViewModel: ViewModelType, Injectable {

  // MARK: - Property

  @Published
  var state: SignupState = .init()

  @Inject(AppStateKey.self)
  private var appState: AppState

  @Inject(SignupRepositoryTypeKey.self)
  private var signupRepository: SignupRepositoryType

  @Inject(LoginKey.self)
  private var login: Loginable

  private var tokenManager: TokenManagerType
  
  private let container: ProgressMainContainer

  private let taskBag: AnyCancelTaskBag = .init()

  // MARK: - Init

  init(
    container: ProgressMainContainer,
    tokenManager: TokenManagerType
  ) {
    self.container = container
    defer {
      self.container.delegate = self
      self.container.mains.forEach { main in
        guard var main = main as? SignupMain else { return }
        main.repository = self.signupRepository
      }
    }
    self.tokenManager = tokenManager
  }

  // MARK: - Method

  func trigger(_ action: SignupAction) {
    switch action {
    case .initUI: self.initUI()
    case .nickname(let nickname): self.updateNicknameIfNeeded(nickname)
    case .next: self.next()
    case .previous: self.previous()
    }
  }

  func trigger(_ action: SignupAction) async {
    switch action {
    case .initUI: await self.initUI()
    case .nickname(let nickname): self.updateNicknameIfNeeded(nickname)
    case .next: await self.next()
    case .previous: await self.previous()
    }
  }

  private func initUI() {
    self.taskBag.cancel()

    Task { [weak self] in
      await self?.initUI()
    }
    .store(in: self.taskBag)
  }
  
  private func initUI() async {
    await self.container.updateFirstMain()
  }

  private func next() {
    self.taskBag.cancel()

    Task { [weak self] in
      await self?.next()
    }
    .store(in: self.taskBag)
  }
  
  private func next() async {
    await self.container.next()
  }

  private func previous() {
    self.taskBag.cancel()

    Task { [weak self] in
      await self?.previous()
    }
    .store(in: self.taskBag)
  }
  
  private func previous() async {
    await self.container.previous()
  }

  private func updateNicknameIfNeeded(_ nickname: String) {
    guard let signupNickname = self.state.currentMain as? SignupNickname else {
      return
    }
    signupNickname.updateNickname(nickname: nickname)
    self.state.bottomButton.isDisable = signupNickname.isBottomDisable
  }
  
  private func requestSignup() async throws {
    let request = self.container.mains.reduce(SignupRequest()) { partialResult, main in
      guard let main = main as? SignupMain else { return partialResult  }
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
        title: .confirm,
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
    self.endLoading()
    self.state.successSignup = true
    self.appState.entranceRouter.goMain()
  }

  @MainActor
  private func startLoading() {
    self.state.bottomButton.isLoading = true
    self.state.bottomButton.isDisable = true
  }

  @MainActor
  private func endLoading() {
    self.state.bottomButton.isLoading = false
    self.state.bottomButton.isDisable = false
  }
}


// MARK: - ProgressMainContainerDelegate

extension SignupViewModel: ProgressMainContainerDelegate {
  
  func dismiss() async {
    _ = self.appState.entranceRouter.popLast()
  }
  
  func complete() async {
    await self.startLoading()

    do {
      try await self.requestSignup()
      try await self.requestLogin()
      await self.successSignup()
    } catch {
      await self.handleError(error)
    }
  }
  
  @MainActor
  func updateMain(
    _ main: Core.ProgressMain, 
    value: Double,
    from: Core.ProgressMainContainer.From
  ) {
    self.state.currentMain = main as? SignupMain
    self.state.progress.value = value
    self.state.bottomButton.isDisable = main.isBottomDisable
    if from != .updateFirstMain  {
      self.state.progress.isAnimation = true
    }
  }
}
