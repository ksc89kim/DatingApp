//
//  MyPageEditState.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Util

struct MyPageEditState {

  // MARK: - Property

  var nickname: String

  var introduce: String

  var height: String

  var job: String

  var gameGenre: [String]

  var mbti: String

  var isSaving: Bool

  var isPresentAlert: Bool

  var alertMessage: String

  var availableGenreChips: [Chip]

  var selectedGenreChips: Set<Chip>

  // MARK: - Init

  init(
    nickname: String = "",
    introduce: String = "",
    height: String = "",
    job: String = "",
    gameGenre: [String] = [],
    mbti: String = "",
    isSaving: Bool = false,
    isPresentAlert: Bool = false,
    alertMessage: String = "",
    availableGenreChips: [Chip] = [],
    selectedGenreChips: Set<Chip> = []
  ) {
    self.nickname = nickname
    self.introduce = introduce
    self.height = height
    self.job = job
    self.gameGenre = gameGenre
    self.mbti = mbti
    self.isSaving = isSaving
    self.isPresentAlert = isPresentAlert
    self.alertMessage = alertMessage
    self.availableGenreChips = availableGenreChips
    self.selectedGenreChips = selectedGenreChips
  }
}
