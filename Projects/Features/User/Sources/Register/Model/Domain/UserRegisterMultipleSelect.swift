//
//  UserRegisterMultipleSelect.swift
//  User
//
//  Created by kim sunchul on 2/17/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import Util
import UserInterface

final class UserRegisterMultipleSelect: UserRegisterMain {
  
  // MARK: - Property
  
  let title: LocalizedStringResource
  
  let subTitle: LocalizedStringResource?
  
  let key: String
  
  let items: [Chip]
  
  var selections: Set<Chip>
  
  var isBottomDisable: Bool = false
  
  weak var repository: UserRegisterRepositoryType?
  
  // MARK: - Init
  
  init(
    key: String,
    title: LocalizedStringResource,
    subTitle: LocalizedStringResource? = nil,
    items: [Chip] = [],
    selections: Set<Chip>
  ) {
    self.selections = selections
    self.key = key
    self.title = title
    self.items = items
    self.subTitle = subTitle
  }
  
  // MARK: - Method
  
  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    var request = request
    let parameters: Dictionary = .init(
      uniqueKeysWithValues: self.selections.map { ($0.key, $0.title) }
    )
    request.multipleSelectParameters[self.key] = parameters
    return request
  }
  
  func updateSelections(_ selections: Set<Chip>) {
    self.selections = selections
    self.isBottomDisable = self.selections.isEmpty
  }
}


// MARK: - Factory

extension UserRegisterMultipleSelect {
  
  static var game: UserRegisterMultipleSelect {
    return .init(
      key: "gameGenre", 
      title: "어떤 게임 장르를 좋아해요?",
      items: [
        .init(key: "aos_moba", title: "AOS,MOBA"),
        .init(key: "rpg_mmorpg", title: "RPG,MMORPG"),
        .init(key: "shooting_fps_tps", title: "슈팅,FPS,TPS"),
        .init(key: "real_time_strategy_rts", title: "실시간 전략, RTS"),
        .init(key: "action_fighting", title: "액션 대전 격투"),
        .init(key: "puzzle_board", title: "퍼즐/보드"),
        .init(key: "tycoon", title: "타이쿤"),
        .init(key: "nurturing_simulation", title: "육성 시뮬레이션"),
        .init(key: "racing", title: "경주"),
        .init(key: "rhythm", title: "리듬"),
        .init(key: "etc", title: "기타"),
        .init(key: "quiz", title: "퀴즈")
      ],
      selections: .init()
    )
  }
}
