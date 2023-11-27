//
//  ChatDIRegister.swift
//  Chat
//
//  Created by kim sunchul on 11/27/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import ChatInterface

public struct ChatDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(ChatHomeViewKey.self) { ChatHomeView() }
    }
  }
}
