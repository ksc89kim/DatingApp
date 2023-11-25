//
//  ChatChosenListRow.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatChosenListRow: View {
  
  // MARK: - Property

  var body: some View {
    VStack(alignment: .leading) {
      Text("찜 목록")
        .systemScaledFont(font: .semibold, size: 14)
        .padding(.leading, 15)
        .padding(.top, 5)
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(1...10, id: \.self) { _ in
            ChatChosenListRowItem()
          }
        }
      }
      .scrollIndicators(.hidden)
      .frame(height: 100)
    }
    .listRowSeparator(.hidden)
  }
}


#Preview {
  ChatChosenListRow()
}
