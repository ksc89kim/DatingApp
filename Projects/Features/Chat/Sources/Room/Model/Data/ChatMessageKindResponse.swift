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
  
  // MARK: - Define
  
  private enum CodingKeys: String, CodingKey {
    case type, content
  }
  
  private enum MessageKindType: String, Codable {
    case text
  }
  
  // MARK: - Property
  
  var kind: ChatMessageKind {
    switch self {
    case .text(let text):
      return .text(text)
    }
  }
  
  // MARK: - Init
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(MessageKindType.self, forKey: .type)
    
    switch type {
    case .text:
      let content = try container.decode(String.self, forKey: .content)
      self = .text(content)
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    switch self {
    case .text(let content):
      try container.encode(MessageKindType.text, forKey: .type)
      try container.encode(content, forKey: .content)
    }
  }
}
