//
//  UserProfileView.swift
//  User
//
//  Created by kim sunchul on 11/15/25.
//

import SwiftUI
import Util
import UserInterface

public struct UserProfileView: View {

  // MARK: - Property

  @ObservedObject
  private var viewModel: UserProfileViewModel

  // MARK: - Init

  public init(viewModel: UserProfileViewModel) {
    self.viewModel = viewModel
  }

  @Environment(\.dismiss)
  private var dismiss

  private var imageHeight: CGFloat {
    UIScreen.main.bounds.height * 0.55
  }

  private var imageIndexBinding: Binding<Int> {
    Binding(
      get: { self.viewModel.state.currentImageIndex },
      set: { self.viewModel.trigger(.swipeImage(index: $0)) }
    )
  }

  private var isShowingMoreMenuBinding: Binding<Bool> {
    Binding(
      get: { self.viewModel.state.isShowingMoreMenu },
      set: { self.viewModel.trigger(.showMoreMenu($0)) }
    )
  }

  private var isPresentAlertBinding: Binding<Bool> {
    Binding(
      get: { self.viewModel.state.isPresentAlert },
      set: { _ in self.viewModel.trigger(.dismissAlert) }
    )
  }

  public var body: some View {
    GeometryReader { rootGeo in
      self.content(safeAreaTop: rootGeo.safeAreaInsets.top)
    }
    .background(Color(.systemBackground))
    .navigationBarHidden(true)
    .confirmationDialog(
      "더보기",
      isPresented: self.isShowingMoreMenuBinding,
      titleVisibility: .hidden
    ) {
      Button("신고하기", role: .destructive) {
        self.viewModel.trigger(.report)
      }
      Button("차단하기", role: .destructive) {
        self.viewModel.trigger(.block)
      }
      Button("취소", role: .cancel) {}
    }
    .alert(
      isPresented: self.isPresentAlertBinding
    ) {
      self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.loadProfile)
    }
    .onChange(
      of: self.viewModel.state.shouldDismiss
    ) { _, newValue in
      if newValue {
        self.dismiss()
      }
    }
  }

  // MARK: - Private

  private func content(
    safeAreaTop: CGFloat
  ) -> some View {
    ZStack {
      if let errorMessage = self.viewModel.state
        .errorMessage {
        UserProfileErrorView(
          message: errorMessage,
          onRetry: {
            self.viewModel.trigger(.loadProfile)
          }
        )
      } else {
        VStack(spacing: 0) {
          ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
              UserProfileImageSection(
                imageURLs: self.viewModel.state
                  .profileImageURLs,
                currentIndex: self.imageIndexBinding,
                nickname: self.viewModel.state.nickname,
                age: self.viewModel.state.age,
                height: self.viewModel.state.height,
                job: self.viewModel.state.job,
                imageHeight: self.imageHeight,
                safeAreaTop: safeAreaTop
              )
              UserProfileIntroduceSection(
                introduce: self.viewModel.state
                  .introduce
              )
              UserProfileBasicInfoSection(
                age: self.viewModel.state.age,
                height: self.viewModel.state.height,
                job: self.viewModel.state.job,
                mbti: self.viewModel.state.mbti
              )
              UserProfileInterestSection(
                chips: self.viewModel.state
                  .gameGenreChips,
                selections: self.viewModel.state
                  .gameGenreSelections
              )
            }
            .padding(.bottom, 100)
          }
          .scrollBounceBehavior(.basedOnSize)
          .ignoresSafeArea(edges: .top)
        }
        VStack {
          Spacer()
          UserProfileBottomButtonSection(
            entryType: self.viewModel.state.entryType,
            onSkip: {
              self.viewModel.trigger(.skip)
            },
            onLike: {
              self.viewModel.trigger(.like)
            },
            onOpenChat: {
              self.viewModel.trigger(.openChat)
            }
          )
        }
      }
      UserProfileFloatingNavigationBar(
        entryType: self.viewModel.state.entryType,
        onBack: {
          self.viewModel.trigger(.back)
        },
        onMore: {
          self.viewModel.trigger(.showMoreMenu(true))
        }
      )
      UserProfileLoadingOverlay(
        isLoading: self.viewModel.state.isLoading
      )
    }
  }

}


// MARK: - AlertBuildable

extension UserProfileView: AlertBuildable {}

#Preview {
  UserDIRegister.register()
  return UserProfileView(
    viewModel: .init(
      userID: "preview",
      entryType: .matchRecommend
    )
  )
}
