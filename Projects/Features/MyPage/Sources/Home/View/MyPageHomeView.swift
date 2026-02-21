//
//  MyPageHomeView.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import SwiftUI
import DI
import Util
import AppStateInterface
import MyPageInterface

public struct MyPageHomeView: View, Injectable {

  // MARK: - Property

  @ObservedObject
  private var viewModel: MyPageViewModel = DIContainer.resolve(
    for: MyPageViewModelKey.self
  )

  @ObservedObject
  private var appState: AppState = DIContainer.resolve(
    for: AppStateKey.self
  )

  // MARK: - Init

  public init() {}

  // MARK: - Body

  public var body: some View {
    NavigationStack(path: self.$appState.myPageRouter.paths) {
      self.scrollContent
        .navigationBarHidden(true)
        .navigationDestination(for: MyPageRoutePath.self) { path in
          switch path {
          case .edit:
            MyPageEditView(
              viewModel: self.makeEditViewModel()
            )
            .navigationBarBackButtonHidden()
          case .setting:
            MyPageSettingView()
              .navigationBarBackButtonHidden()
          }
        }
    }
    .toolbar(
      self.appState.myPageRouter.paths.isEmpty ? .visible : .hidden,
      for: .tabBar
    )
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
    .onAppear {
      self.viewModel.trigger(.loadProfile)
    }
  }

  // MARK: - Private

  private var scrollContent: some View {
    ZStack {
      ScrollView(.vertical) {
        VStack(spacing: 12) {
          MyPageProfileHeaderSection(
            nickname: self.viewModel.state.nickname,
            isVerified: self.viewModel.state.isVerified,
            profileImageURL: self.viewModel.state.profileImageURLs.first,
            onTapEdit: {
              self.viewModel.trigger(.navigateToEdit)
            },
            onTapSetting: {
              self.viewModel.trigger(.navigateToSetting)
            }
          )

          MyPageCompletionSection(
            completionPercentage:
              self.viewModel.state.profileCompletionPercentage,
            completionTips: self.viewModel.state.completionTips,
            onTapTip: { id in
              self.viewModel.trigger(.selectCompletionTip(id: id))
            }
          )

          MyPagePremiumSection(
            superLikeCount: self.viewModel.state.superLikeCount,
            boostCount: self.viewModel.state.boostCount,
            onTapSuperLike: {
              self.viewModel.trigger(.purchaseSuperLike)
            },
            onTapBoost: {
              self.viewModel.trigger(.purchaseBoost)
            },
            onTapSubscription: {
              self.viewModel.trigger(.upgradeSubscription)
            }
          )

          MyPageSubscriptionSection(
            onTapUpgrade: {
              self.viewModel.trigger(.upgradeSubscription)
            }
          )
        }
        .padding(.top, 16)
        .padding(.bottom, 24)
      }
      .background(Color(.secondarySystemGroupedBackground))

      if self.viewModel.state.isLoading {
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black.opacity(0.1))
      }
    }
  }

  // MARK: - Factory

  private func makeEditViewModel() -> MyPageEditViewModel {
    let input = MyPageEditInput(
      nickname: self.viewModel.state.nickname,
      introduce: self.viewModel.state.introduce,
      height: self.viewModel.state.height,
      job: self.viewModel.state.job,
      gameGenre: self.viewModel.state.gameGenre,
      mbti: self.viewModel.state.mbti
    )
    let editVM = MyPageEditViewModel(input: input)
    editVM.onSaveSuccess = {
      [weak viewModel = self.viewModel,
       weak appState = self.appState] in
      appState?.myPageRouter.popLast()
      viewModel?.trigger(.loadProfile)
    }
    return editVM
  }
}


#Preview {
  MyPageDIRegister.register()
  return MyPageHomeView()
}
