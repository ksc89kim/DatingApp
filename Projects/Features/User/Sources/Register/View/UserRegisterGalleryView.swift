//
//  UserRegisterGalleryView.swift
//  User
//
//  Created by kim sunchul on 5/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct UserRegisterGalleryView: View {
  
  // MARK: - Property
  
  let firstImage: Binding<Image?>
  
  let secondImage: Binding<Image?>
    
  let onAppend: (() -> Void)?
  
  let onDelete: ((UserRegisterPhotoIndex) -> Void)?
  
  var body: some View {
    VStack(alignment: .leading) {
      UserRegisterTitleView(
        title: "회원님의 사진을 선택하세요",
        subTitle: "시작하려면 최소 2장의 사진을 업로드하세요"
      )
      HStack {
        Spacer()
        UserRegisterPictureView(
          image: self.firstImage,
          onAppend: {
            self.onAppend?()
          },
          onDelete: {
            self.onDelete?(.first)
          }
        )
        Spacer()
          .frame(width: 12)
        UserRegisterPictureView(
          image: self.secondImage,
          onAppend: {
            self.onAppend?()
          },
          onDelete: {
            self.onDelete?(.second)
          }
        )
        Spacer()
      }
    }
  }
}


#Preview {
  UserRegisterGalleryView(
    firstImage: .constant(nil),
    secondImage: .constant(nil),
    onAppend: { },
    onDelete: { _ in }
  )
}
