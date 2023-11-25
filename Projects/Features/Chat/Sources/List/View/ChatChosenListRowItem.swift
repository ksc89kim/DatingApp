//
//  ChatChosenListRowItem.swift
//  Chat
//
//  Created by kim sunchul on 11/24/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI
import Util

struct ChatChosenListRowItem: View {

  // MARK: - Property

  var body: some View {
    VStack(spacing: 8) {
      Circle()
        .frame(width: 65)
        .overlay {
          ChatAsset.Assets.testProfile.swiftUIImage
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
        }
      Text("Kim")
        .systemScaledFont(font: .semibold, size: 12)
    }
    .padding(.leading, 15)
  }
}


#Preview {
  ChatChosenListRowItem()
}
