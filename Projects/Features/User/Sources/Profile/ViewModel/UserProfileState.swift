//
//  UserProfileState.swift
//  User
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import Util
import UserInterface

public struct UserProfileState {

  // MARK: - Property

  var nickname: String

  var age: Int?

  var height: String

  var job: String

  var profileImageURLs: [URL]

  var gameGenreChips: [Chip]

  var gameGenreSelections: Set<Chip>

  var introduce: String

  var mbti: String

  var currentImageIndex: Int

  var entryType: UserProfileEntryType

  var isLoading: Bool

  var alert: BaseAlert

  var isPresentAlert: Bool

  var shouldDismiss: Bool

  var didLike: Bool

  var didSkip: Bool

  var didReport: Bool

  var didBlock: Bool

  var isShowingMoreMenu: Bool

  var errorMessage: String?

  // MARK: - Init

  init(
    nickname: String = "",
    age: Int? = nil,
    height: String = "",
    job: String = "",
    profileImageURLs: [URL] = [],
    gameGenreChips: [Chip] = [],
    gameGenreSelections: Set<Chip> = [],
    introduce: String = "",
    mbti: String = "",
    currentImageIndex: Int = 0,
    entryType: UserProfileEntryType = .chatList,
    isLoading: Bool = false,
    alert: BaseAlert = .empty,
    isPresentAlert: Bool = false,
    shouldDismiss: Bool = false,
    didLike: Bool = false,
    didSkip: Bool = false,
    didReport: Bool = false,
    didBlock: Bool = false,
    isShowingMoreMenu: Bool = false,
    errorMessage: String? = nil
  ) {
    self.nickname = nickname
    self.age = age
    self.height = height
    self.job = job
    self.profileImageURLs = profileImageURLs
    self.gameGenreChips = gameGenreChips
    self.gameGenreSelections = gameGenreSelections
    self.introduce = introduce
    self.mbti = mbti
    self.currentImageIndex = currentImageIndex
    self.entryType = entryType
    self.isLoading = isLoading
    self.alert = alert
    self.isPresentAlert = isPresentAlert
    self.shouldDismiss = shouldDismiss
    self.didLike = didLike
    self.didSkip = didSkip
    self.didReport = didReport
    self.didBlock = didBlock
    self.isShowingMoreMenu = isShowingMoreMenu
    self.errorMessage = errorMessage
  }
}
