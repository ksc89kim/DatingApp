//
//  HomeDiscoverView.swift
//  Main
//
//  Created by claude on 2/21/26.
//

import SwiftUI
import Util

struct HomeDiscoverView: View {

  // MARK: - Property

  @ObservedObject
  var viewModel: HomeViewModel

  private let gridColumns: [GridItem] = [
    GridItem(.flexible(), spacing: 10),
    GridItem(.flexible(), spacing: 10)
  ]

  // MARK: - Body

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading, spacing: 16) {
        HomeHeaderView(onFilter: {})

        if self.viewModel.state.isEmpty {
          self.emptySection
        } else {
          self.gridSection
        }
      }
      .padding(.top, 16)
    }
    .refreshable {
      await self.viewModel.trigger(.refresh)
    }
    .overlay {
      if self.viewModel.state.isLoading {
        ProgressView()
      }
    }
  }

  // MARK: - Private

  private var gridSection: some View {
    LazyVGrid(columns: self.gridColumns, spacing: 10) {
      ForEach(self.viewModel.state.cards) { card in
        HomeCardView(card: card) {
          self.viewModel.trigger(.showProfile(userID: card.userID))
        }
      }
    }
    .padding(.horizontal, 16)
  }

  private var emptySection: some View {
    VStack(spacing: 12) {
      Spacer()
      Text("주변에 새로운 사람이 없어요")
        .systemScaledFont(style: .body)
        .foregroundStyle(.gray)
      Spacer()
    }
    .frame(maxWidth: .infinity, minHeight: 200)
  }
}
