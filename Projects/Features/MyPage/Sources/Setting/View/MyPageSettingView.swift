//
//  MyPageSettingView.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import SwiftUI
import DI
import Util

struct MyPageSettingView: View {

  // MARK: - Property

  @ObservedObject
  private var viewModel: MyPageSettingViewModel = DIContainer.resolve(
    for: MyPageSettingViewModelKey.self
  )

  @Environment(\.dismiss)
  private var dismiss

  // MARK: - Body

  var body: some View {
    List {
      self.profileSection
      self.notificationSection
      self.accountSection
      self.appInfoSection
    }
    .listStyle(.insetGrouped)
    .navigationBarHidden(true)
    .safeAreaInset(edge: .top) {
      self.headerBar
    }
    .alert(
      "로그아웃",
      isPresented: self.$viewModel.state.isPresentLogoutAlert
    ) {
      Button("취소", role: .cancel) {}
      Button("로그아웃", role: .destructive) {
        self.viewModel.trigger(.confirmLogout)
      }
    } message: {
      Text("정말 로그아웃하시겠습니까?")
    }
    .alert(
      "회원 탈퇴",
      isPresented: self.$viewModel.state.isPresentDeleteAlert
    ) {
      Button("취소", role: .cancel) {}
      Button("탈퇴하기", role: .destructive) {
        self.viewModel.trigger(.confirmDeleteAccount)
      }
    } message: {
      Text(
        "탈퇴하면 모든 데이터가 삭제되며\n복구할 수 없습니다."
      )
    }
    .alert(
      "오류",
      isPresented: self.$viewModel.state.isPresentAlert
    ) {
      Button("확인") {
        self.viewModel.trigger(.dismissAlert)
      }
    } message: {
      Text(self.viewModel.state.alertMessage)
    }
    .overlay {
      if self.viewModel.state.isLoading {
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black.opacity(0.1))
      }
    }
  }

  // MARK: - Header Bar

  private var headerBar: some View {
    ZStack {
      Text("설정")
        .systemScaledFont(
          font: .semibold,
          size: 17
        )
        .foregroundStyle(Color(.label))
      HStack {
        Button {
          self.dismiss()
        } label: {
          HStack(spacing: 4) {
            Image(systemName: "chevron.left")
              .font(.system(size: 15))
            Text("뒤로")
              .systemScaledFont(
                font: .regular,
                size: 16
              )
          }
          .foregroundStyle(Color(.label))
        }
        Spacer()
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background(
      Color(.systemBackground)
        .ignoresSafeArea(edges: .top)
    )
  }

  // MARK: - Profile Section

  private var profileSection: some View {
    Section {
      HStack {
        Image(systemName: "person.circle.fill")
          .font(.system(size: 22))
          .foregroundStyle(Color(.secondaryLabel))
        Text("프로필")
          .systemScaledFont(
            font: .regular,
            size: 15
          )
          .foregroundStyle(Color(.label))
        Spacer()
        Image(systemName: "chevron.right")
          .font(.system(size: 13))
          .foregroundStyle(Color(.tertiaryLabel))
      }
    } header: {
      Text("프로필")
    }
  }

  // MARK: - Notification Section

  private var notificationSection: some View {
    Section {
      Toggle(
        isOn: Binding(
          get: { self.viewModel.state.isMatchNotificationOn },
          set: { _ in
            self.viewModel.trigger(.toggleMatchNotification)
          }
        )
      ) {
        HStack(spacing: 10) {
          Image(systemName: "bell.fill")
            .font(.system(size: 15))
            .foregroundStyle(Color(.secondaryLabel))
          Text("매칭 알림")
            .systemScaledFont(
              font: .regular,
              size: 15
            )
            .foregroundStyle(Color(.label))
        }
      }
      .tint(
        UtilAsset.MainColor.accent.swiftUIColor
      )
    } header: {
      Text("알림")
    }
  }

  // MARK: - Account Section

  private var accountSection: some View {
    Section {
      Button {
        self.viewModel.trigger(.presentLogoutAlert)
      } label: {
        HStack(spacing: 10) {
          Image(
            systemName: "rectangle.portrait.and.arrow.right"
          )
          .font(.system(size: 15))
          .foregroundStyle(.red)
          Text("로그아웃")
            .systemScaledFont(
              font: .regular,
              size: 15
            )
            .foregroundStyle(.red)
        }
      }
      Button {
        self.viewModel.trigger(.presentDeleteAlert)
      } label: {
        HStack(spacing: 10) {
          Image(
            systemName: "person.crop.circle.badge.minus"
          )
          .font(.system(size: 15))
          .foregroundStyle(.red)
          Text("회원 탈퇴")
            .systemScaledFont(
              font: .regular,
              size: 15
            )
            .foregroundStyle(.red)
        }
      }
    } header: {
      Text("계정")
    }
  }

  // MARK: - App Info Section

  private var appInfoSection: some View {
    Section {
      HStack {
        HStack(spacing: 10) {
          Image(systemName: "info.circle")
            .font(.system(size: 15))
            .foregroundStyle(
              Color(.secondaryLabel)
            )
          Text("버전")
            .systemScaledFont(
              font: .regular,
              size: 15
            )
            .foregroundStyle(Color(.label))
        }
        Spacer()
        Text(self.appVersion)
          .systemScaledFont(
            font: .regular,
            size: 14
          )
          .foregroundStyle(Color(.tertiaryLabel))
      }
    } header: {
      Text("앱 정보")
    }
  }

  // MARK: - Private

  private var appVersion: String {
    Bundle.main.infoDictionary?[
      "CFBundleShortVersionString"
    ] as? String ?? "1.0.0"
  }
}
