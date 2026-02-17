//
//  MatchingEmptyView.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import SwiftUI
import Util

struct MatchingEmptyView: View {

  // MARK: - Property

  let onRefresh: () -> Void

  // MARK: - Body

  var body: some View {
    VStack(spacing: 24) {
      Image(systemName: "person.2.slash")
        .font(.system(size: 60))
        .foregroundStyle(.gray.opacity(0.5))

      Text("추천 카드가 없습니다")
        .systemScaledFont(style: .boldTitle)
        .foregroundStyle(.gray)

      Text("나중에 다시 확인해보세요!")
        .systemScaledFont(style: .body)
        .foregroundStyle(.gray.opacity(0.7))

      Button {
        self.onRefresh()
      } label: {
        Text("새로고침")
          .systemScaledFont(style: .bottomButton)
          .foregroundStyle(.white)
          .padding(.horizontal, 32)
          .padding(.vertical, 12)
          .background(UtilAsset.MainColor.background.swiftUIColor)
          .clipShape(Capsule())
      }
      .buttonStyle(PressedButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
