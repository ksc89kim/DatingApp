//
//  MyPageState.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import Util

struct MyPageState {

  // MARK: - Property

  var nickname: String = ""

  var age: Int? = nil

  var height: String = ""

  var job: String = ""

  var profileImageURLs: [String] = []

  var gameGenre: [String] = []

  var introduce: String = ""

  var mbti: String = ""

  var isLoading: Bool = false

  var isPresentAlert: Bool = false

  var alertMessage: String = ""

  var currentImageIndex: Int = 0

  var gameGenreChips: [Chip] = []

  var gameGenreSelections: Set<Chip> = []

  var profileCompletionPercentage: Int = 0

  var completionTips: [ProfileCompletionTip] = []

  var isVerified: Bool = false

  var superLikeCount: Int = 0

  var boostCount: Int = 0
}
