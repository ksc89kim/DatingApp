//
//  ChatRoomDateHeaderView.swift
//  Chat
//
//  Created by kim sunchul on 1/5/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatRoomDateHeaderView: View {

  // MARK: - Property

  let date: Date

  private let dateFormater: DateFormatter = {
    let formmater = DateFormatter()
    formmater.dateFormat = "yyyy. MM. dd a h:mm"
    return formmater
  }()

  var body: some View {
    Text(self.dateFormater.string(from: self.date))
      .foregroundStyle(ChatAsset.Assets.chatMessageDateHeader.swiftUIColor)
      .systemScaledFont(font: .medium, size: 14)
      .padding()
  }
}


#Preview {
  ChatRoomDateHeaderView(date: .now)
}
