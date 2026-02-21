//
//  MyPageEditAction.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Util

enum MyPageEditAction {
  case load(MyPageEditInput)
  case updateNickname(String)
  case updateIntroduce(String)
  case updateHeight(String)
  case updateJob(String)
  case updateSelectedGenres(Set<Chip>)
  case updateMbti(String)
  case save
  case dismiss
  case dismissAlert
}
