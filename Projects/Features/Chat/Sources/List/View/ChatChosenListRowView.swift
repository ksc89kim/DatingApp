//
//  ChatChosenListRowView.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatChosenListRowView: View {
  
  // MARK: - Property

  var body: some View {
    VStack(alignment: .leading) {
      Text("친구 요청")
        .systemScaledFont(font: .semibold, size: 16)
        .padding(.leading, 15)
        .padding(.top, 5)
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(1...10, id: \.self) { _ in
            ChatChosenListRowItemView()
          }
        }
      }
      .scrollIndicators(.hidden)
      .frame(height: 100)
    }
  }
}


#Preview {
  ChatChosenListRowView()
}
