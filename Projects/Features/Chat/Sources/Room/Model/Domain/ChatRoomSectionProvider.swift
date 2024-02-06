//
//  ChatRoomSectionProvider.swift
//  Chat
//
//  Created by kim sunchul on 2/5/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import ChatInterface


protocol ChatRoomSectionProviderDelegate: AnyObject {
  
  func items() -> [ChatMessageSectionItem]
  
  func setItems(items: [ChatMessageSectionItem])
}


final class ChatRoomSectionProvider {
  
  // MARK: - Property
    
  weak var delegate: ChatRoomSectionProviderDelegate?
  
  // MARK: - Method
  
  /// 전체 채팅 메시지를 설정합니다.
  @MainActor
  func setItems(_ items: [ChatMessage]) {
    let items = items.reversed().enumerated().map { offset, message in
      ChatMessageSectionItem(message: message, index: offset)
    }
    
    self.delegate?.setItems(items: items)
  }
  
  /// 과거 채팅 메시지를 상단에 추가합니다.
  @MainActor
  func appendItems(_ items: [ChatMessage]) {
    var willChangeItems = self.delegate?.items() ?? []
    let startIndex = willChangeItems.count
    let appendItems = items.reversed().enumerated().map { offset, message in
      ChatMessageSectionItem(message: message, index: startIndex + offset)
    }
    willChangeItems.append(contentsOf: appendItems)
    self.delegate?.setItems(items: willChangeItems)
  }
  
  /// 현재 채팅 메시지를 하단에 추가합니다.
  @MainActor
  func insertItem(_ item: ChatMessage) {
    var willChangeItems = self.delegate?.items() ?? []
    willChangeItems.insert(.init(message: item, index: 0), at: 0)
    willChangeItems = willChangeItems
      .enumerated()
      .map { (offset: Int, item: ChatMessageSectionItem) -> ChatMessageSectionItem in
        var item = item
        item.index = offset
        return item
      }
    
    self.delegate?.setItems(items: willChangeItems)
  }
}
