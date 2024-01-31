//
//  ChatRoomMeta.swift
//  ChatInterface
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation

public struct ChatRoomMeta {
    
  public let socketURL: URL?
  
  public let partner: ChatUser
  
  // MARK: - Init
  
  public init(
    partner: ChatUser,
    socketURL: URL?
  ) {
    self.partner = partner
    self.socketURL = socketURL
  }
}
