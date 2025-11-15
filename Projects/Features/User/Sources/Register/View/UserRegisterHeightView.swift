//
//  UserRegisterHeightView.swift
//  User
//
//  Created by kim sunchul on 2/13/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterHeightView: View {
  
  // MARK: - Property
  
  private let heights: [String] = (100...220).map { height in
    "\(height)cm"
  }
  
  @Binding
  var selection: String
  
  var body: some View {
    VStack(alignment: .leading) {
      UserRegisterTitleView(
        title: "회원님 환영해요.\n이제 키를 입력해볼까요?",
        subTitle: nil
      )
      PickerView(array: self.heights, selectedItem: self.$selection)
    }
  }
}


#Preview {
  UserRegisterHeightView(selection: .constant("175cm"))
}
