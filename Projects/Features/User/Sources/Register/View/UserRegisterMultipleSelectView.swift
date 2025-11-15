//
//  UserRegisterMultipleSelectView.swift
//  User
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterMultipleSelectView: View {
  
  // MARK: - Property
  
  let title: LocalizedStringResource
  
  let subTitle: LocalizedStringResource?
  
  let items: [Chip]
  
  @Binding
  var selections: Set<Chip>
  
  var body: some View {
    VStack(alignment: .leading) {
      UserRegisterTitleView(
        title: self.title,
        subTitle: self.subTitle
      )
      ScrollView {
        ChipContainerView(
          items: self.items,
          selections: self.$selections
        )
      }
      .overlay {
        VStack {
          Spacer()
          LinearGradient(
            colors: [
              .white,
              .clear
            ],
            startPoint: .bottom,
            endPoint: .top
          )
          .frame(height: 100)
        }
        .allowsHitTesting(false)
      }
      .scrollIndicators(.hidden)
    }
  }
}


#Preview {
  UserRegisterMultipleSelectView(
    title: "어떤 게임 종류를 좋아하시나요?",
    subTitle: "",
    items: [
      .init(key: "active", title: "활발한"),
      .init(key: "quiet", title: "조용한"),
      .init(key: "cute", title: "애교가 많은"),
      .init(key: "calm", title: "얌전한"),
      .init(key: "leader", title: "영장짐"),
      .init(key: "friendly", title: "친화적")
    ],
    selections: .constant([])
  )
}
