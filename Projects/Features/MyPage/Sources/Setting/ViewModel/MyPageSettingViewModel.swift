//
//  MyPageSettingViewModel.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import Foundation
import SwiftUI
import Core
import DI
import AppStateInterface
import MyPageInterface

final class MyPageSettingViewModel: ViewModelType, Injectable {

  // MARK: - Define

  private enum TaskKey {
    static let logout = "logoutKey"
    static let deleteAccount = "deleteAccountKey"
  }

  // MARK: - Property

  @Published
  var state: MyPageSettingState = .init()

  @Inject(MyPageSettingRepositoryTypeKey.self)
  private var repository: MyPageSettingRepositoryType

  @Inject(AppStateKey.self)
  private var appState: AppState

  private let taskBag: AnyCancelTaskDictionaryBag = .init()

  // MARK: - Method

  func trigger(_ action: MyPageSettingAction) {
    switch action {
    case .toggleMatchNotification:
      self.state.isMatchNotificationOn.toggle()
    case .presentLogoutAlert:
      self.state.isPresentLogoutAlert = true
    case .presentDeleteAlert:
      self.state.isPresentDeleteAlert = true
    case .confirmLogout:
      self.performLogout()
    case .confirmDeleteAccount:
      self.performDeleteAccount()
    case .dismissAlert:
      self.state.isPresentAlert = false
      self.state.alertMessage = ""
    }
  }

  // MARK: - Private

  private func performLogout() {
    self.taskBag[TaskKey.logout]?.cancel()

    Task { [weak self] in
      await self?.logout()
    }
    .store(in: self.taskBag, for: TaskKey.logout)
  }

  private func logout() async {
    await self.setLoading(true)
    do {
      try await self.repository.logout()
      await MainActor.run {
        withAnimation {
          self.appState.entranceRouter.set(paths: [.launch])
        }
      }
    } catch {
      await self.handleError(error)
    }
    await self.setLoading(false)
  }

  private func performDeleteAccount() {
    self.taskBag[TaskKey.deleteAccount]?.cancel()

    Task { [weak self] in
      await self?.deleteAccount()
    }
    .store(in: self.taskBag, for: TaskKey.deleteAccount)
  }

  private func deleteAccount() async {
    await self.setLoading(true)
    do {
      try await self.repository.deleteAccount()
      await MainActor.run {
        withAnimation {
          self.appState.entranceRouter.set(paths: [.launch])
        }
      }
    } catch {
      await self.handleError(error)
    }
    await self.setLoading(false)
  }

  // MARK: - MainActor

  @MainActor
  private func setLoading(_ isLoading: Bool) {
    self.state.isLoading = isLoading
  }

  @MainActor
  private func handleError(_ error: Error) {
    self.state.alertMessage = error.localizedDescription
    self.state.isPresentAlert = true
  }
}
