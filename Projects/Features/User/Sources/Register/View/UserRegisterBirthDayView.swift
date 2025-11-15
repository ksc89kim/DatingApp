//
//  UserRegisterBirthDayView.swift
//  User
//
//  Created by kim sunchul on 2/12/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterBirthDayView: View {
  
  // MARK: - Property
  
  @Binding
  var birthDate: Date
  
  var body: some View {
    VStack(alignment: .leading) {
      UserRegisterTitleView(
        title: "회원님의 생일은 언제인가요?",
        subTitle: "회원님의 나이표시에 사용되며, 이후 변경이 불가합니다."
      )
      HStack(alignment: .center) {
        DatePicker(
            "",
            selection: self.$birthDate,
            in: ...Date(),
            displayedComponents: [.date]
        )
        .tint(UtilAsset.MainColor.background.swiftUIColor)
        .frame(width: 320)
        .datePickerStyle(.graphical)
      }
    }
  }
}


#Preview {
  UserRegisterBirthDayView(birthDate: .constant(.now))
}
