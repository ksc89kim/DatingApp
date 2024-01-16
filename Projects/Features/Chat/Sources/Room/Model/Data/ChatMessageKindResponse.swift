//
//  ChatMessageKindResponse.swift
//  Chat
//
//  Created by kim sunchul on 1/10/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface

enum ChatMessageKindResponse: Codable {
  case text(String)
  
  // MARK: - Property
  
  var kind: ChatMessageKind {
    switch self {
    case .text(let text):
      return .text(text)
    }
  }
}
