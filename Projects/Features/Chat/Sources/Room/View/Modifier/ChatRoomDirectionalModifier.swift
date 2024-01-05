//
//  ChatRoomDirectionalModifier.swift
//  Chat
//
//  Created by kim sunchul on 1/4/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatRoomDirectionalModifier: ViewModifier {

  // MARK: - Property

  let isSender: Bool

  let isFirstInGroup: Bool

  private var edges: EdgeInsets {
    if self.isFirstInGroup {
      return EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
    } else {
      return EdgeInsets(top: 2.5, leading: 16, bottom: 2.5, trailing: 16)
    }
  }

  // MARK: - Method

  func body(content: Content) -> some View {
    HStack {
      if self.isSender {
        Spacer()
      }
      content
      if !self.isSender {
        Spacer()
      }
    }
    .padding(self.edges)
  }
}
