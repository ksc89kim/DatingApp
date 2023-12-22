//
//  ChatRoomView.swift
//  Chat
//
//  Created by kim sunchul on 12/22/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import SwiftUI

struct ChatRoomView: View {

  var roomIdx: String

  // MARK: - Property

  var body: some View {
    Text("Hello, World! \(self.roomIdx)")
  }
}


#Preview {
  ChatRoomView(roomIdx: "123")
}
