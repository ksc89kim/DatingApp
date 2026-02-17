//
//  MatchingCardStackView.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import SwiftUI
import Util
import DI
import MatchingInterface

struct MatchingCardStackView: View {

  // MARK: - Property

  @StateObject
  private var viewModel: MatchingCardViewModel = DIContainer.resolve(
    for: MatchingCardViewModelKey.self
  )

  // MARK: - Body

  var body: some View {
    ZStack {
      Color(.systemGroupedBackground)
        .ignoresSafeArea()

      if self.viewModel.state.isLoading {
        ProgressView()
      } else if self.viewModel.state.isEmpty {
        MatchingEmptyView {
          self.viewModel.trigger(.load)
        }
      } else {
        self.cardStackSection
      }
    }
    .overlay {
      if self.viewModel.state.isShowingMatchOverlay,
         let matchedUser = self.viewModel.state.matchedUser {
        MatchSuccessOverlayView(
          matchedUser: matchedUser,
          onSendMessage: {
            self.viewModel.trigger(.sendMessage)
          },
          onContinue: {
            self.viewModel.trigger(.dismissMatchOverlay)
          }
        )
      }
    }
    .alert(
      isPresented: .constant(self.viewModel.state.isPresentAlert)
    ) {
      self.buildAlert(self.viewModel.state.alert)
    }
    .onAppear {
      self.viewModel.trigger(.load)
    }
  }

  // MARK: - Private

  private var cardStackSection: some View {
    VStack(spacing: 16) {
      ZStack {
        ForEach(
          Array(self.visibleCards.enumerated().reversed()),
          id: \.element.id
        ) { index, card in
          MatchingCardView(
            card: card,
            isTop: index == 0,
            onSwipe: { direction in
              self.viewModel.trigger(.swipe(direction: direction))
            },
            onTap: {
              self.viewModel.trigger(
                .showProfile(userID: card.userID)
              )
            }
          )
          .scaleEffect(self.scaleForIndex(index))
          .offset(y: self.offsetForIndex(index))
          .zIndex(Double(self.visibleCards.count - index))
        }
      }
      .padding(.horizontal, 16)

      self.bottomButtonSection
    }
  }

  private var bottomButtonSection: some View {
    HStack(spacing: 40) {
      // Skip 버튼
      Button {
        self.viewModel.trigger(.skip)
      } label: {
        Image(systemName: "xmark")
          .font(.system(size: 24, weight: .bold))
          .foregroundStyle(.red)
          .frame(width: 60, height: 60)
          .background(.white)
          .clipShape(Circle())
          .shadow(color: .red.opacity(0.2), radius: 8)
      }
      .buttonStyle(PressedButtonStyle())

      // Like 버튼
      Button {
        self.viewModel.trigger(.like)
      } label: {
        Image(systemName: "heart.fill")
          .font(.system(size: 24, weight: .bold))
          .foregroundStyle(.green)
          .frame(width: 60, height: 60)
          .background(.white)
          .clipShape(Circle())
          .shadow(color: .green.opacity(0.2), radius: 8)
      }
      .buttonStyle(PressedButtonStyle())
    }
    .padding(.bottom, 8)
  }

  private var visibleCards: [MatchingCardItem] {
    let cards = self.viewModel.state.cards
    let startIndex = self.viewModel.state.currentIndex
    let endIndex = min(startIndex + 3, cards.count)
    guard startIndex < endIndex else { return [] }
    return Array(cards[startIndex..<endIndex])
  }

  private func scaleForIndex(_ index: Int) -> CGFloat {
    return 1.0 - CGFloat(index) * 0.05
  }

  private func offsetForIndex(_ index: Int) -> CGFloat {
    return CGFloat(index) * 8
  }
}
// MARK: - AlertBuildable

extension MatchingCardStackView: AlertBuildable { }

