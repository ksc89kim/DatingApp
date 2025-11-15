//
//  UserRegisterSingleSelectView.swift
//  User
//
//  Created by kim sunchul on 2/14/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterSingleSelectView: View {
  
  // MARK: - Property
  
  let title: LocalizedStringResource
  
  let subTitle: LocalizedStringResource?
  
  let items: [String]
  
  private let layout = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  @Binding
  var selection: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      UserRegisterTitleView(
        title: self.title,
        subTitle: self.subTitle
      )
      ScrollView {
        LazyVGrid(columns: self.layout, spacing: 10) {
          ForEach(self.items, id: \.self) { item in
            Button(
              action: {
                self.selection = item
              },
              label: {
                RoundedRectangle(cornerRadius: 10)
                  .fill(
                    self.selection == item ?
                    UtilAsset.MainColor.background.swiftUIColor
                    : .white
                  )
                  .stroke(
                    self.selection == item ?
                    UtilAsset.MainColor.background.swiftUIColor
                    : UtilAsset.MainColor.placeHolder2.swiftUIColor
                  )
                  .frame(maxWidth: .infinity, minHeight: 50)
                  .overlay {
                    Text(item)
                      .foregroundColor(
                        self.selection == item ?
                        UtilAsset.MainColor.text.swiftUIColor
                        : .black
                      )
                  }
                  .systemScaledFont(font: .semibold, size: 18)
              }
            )
            .buttonStyle(PressedButtonStyle())
          }
        }
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
  UserRegisterSingleSelectView(
    title: "어떤 것을 선택하실래요?",
    subTitle: nil,
    items: (0...100).map { "\($0)" },
    selection: .constant("테스트1")
  )
}
