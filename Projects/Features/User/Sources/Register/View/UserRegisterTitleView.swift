//
//  UserRegisterTitleView.swift
//  User
//
//  Created by kim sunchul on 2/14/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterTitleView: View {
  
  // MARK: - Property
  
  var title: LocalizedStringResource
  
  var subTitle: LocalizedStringResource?
  
  var body: some View {
    Text(self.title)
      .foregroundStyle(.black)
      .systemScaledFont(font: .bold, size: 24)
      .padding(.bottom, 8)
      .accessibilitySortPriority(3)
      .accessibilityAddTraits(.isHeader)
    if let subTitle = self.subTitle {
      Text(subTitle)
        .systemScaledFont(style: .placeHolder)
        .foregroundStyle(UtilAsset.MainColor.placeHolder.swiftUIColor)
        .padding(.bottom, 24)
        .accessibilitySortPriority(2)
    } else {
      Spacer()
        .frame(height: 24)
    }
  }
}


#Preview {
  UserRegisterTitleView(title: "타이틀", subTitle: "서브타이틀")
}
