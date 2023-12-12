//
//  ChatChosenListRowView.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util
import ChatInterface

struct ChatChosenListRowView: View {

  // MARK: - Property

  let items: [ChatChosenSectionItem]

  @Binding
  var appearIndex: Int

  var body: some View {
    VStack(alignment: .leading) {
      Text("친구 요청 목록")
        .systemScaledFont(font: .semibold, size: 16)
        .padding(.leading, 15)
        .padding(.top, 5)
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(
            self.items.enumerated().map { $0 },
            id: \.element.userIdx
          ) { offset, item in
            ChatChosenListRowItemView(item: item)
              .onAppear {
                self.appearIndex = offset
              }
          }
        }
        .padding(.trailing, 15)
      }
      .scrollIndicators(.hidden)
      .frame(height: 100)
    }
  }
}


#Preview {
  ChatChosenListRowView(
    items: [
      .dummy(idx: "0"),
      .dummy(idx: "1"),
      .dummy(idx: "2"),
      .dummy(idx: "3"),
      .dummy(idx: "4"),
      .dummy(idx: "5"),
      .dummy(idx: "6")
    ],
    appearIndex: .constant(0)
  )
}
