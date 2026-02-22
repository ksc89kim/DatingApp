//
//  HomeHeaderView.swift
//  Main
//
//  Created by claude on 2/22/26.
//

import SwiftUI
import Util

struct HomeHeaderView: View {

  // MARK: - Property

  let onFilter: () -> Void

  // MARK: - Body

  var body: some View {
    HStack {
      Text("발견")
        .systemScaledFont(style: .boldLargeTitle)
        .foregroundStyle(.black)

      Spacer()

      HStack(spacing: 8) {
        Button(action: {}) {
          Image(systemName: "bell")
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(.black)
            .frame(width: 40, height: 40)
            .background(Color(.systemGray6))
            .clipShape(Circle())
        }
        .buttonStyle(PressedButtonStyle())

        Button(action: self.onFilter) {
          Image(systemName: "slider.horizontal.3")
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(.black)
            .frame(width: 40, height: 40)
            .background(Color(.systemGray6))
            .clipShape(Circle())
        }
        .buttonStyle(PressedButtonStyle())
      }
    }
    .padding(.horizontal, 16)
  }
}
