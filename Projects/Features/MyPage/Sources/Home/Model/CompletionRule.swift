//
//  CompletionRule.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation

struct CompletionRule {
  let id: String
  let title: String
  let description: String
  let percentageBoost: Int
  let sfSymbol: String
  let check: (MyPageState) -> Bool
}

// MARK: - Rules

extension CompletionRule {
  static let completionRules: [CompletionRule] = [
    .init(
      id: "photo",
      title: "사진 3장 추가하기",
      description: "더 많은 사진으로 매력을 보여주세요",
      percentageBoost: 22,
      sfSymbol: "photo.fill",
      check: { $0.profileImageURLs.count >= 3 }
    ),
    .init(
      id: "introduce",
      title: "자기소개 추가하기",
      description: "나를 표현하는 문장을 적어보세요",
      percentageBoost: 20,
      sfSymbol: "pencil",
      check: { !$0.introduce.isEmpty }
    ),
    .init(
      id: "interest",
      title: "관심사 추가하기",
      description: "공통 관심사로 더 잘 맞는 상대를 찾아요",
      percentageBoost: 15,
      sfSymbol: "gamecontroller.fill",
      check: { !$0.gameGenre.isEmpty }
    ),
    .init(
      id: "height",
      title: "키 입력하기",
      description: "키 정보를 공유해보세요",
      percentageBoost: 10,
      sfSymbol: "ruler.fill",
      check: { !$0.height.isEmpty }
    ),
    .init(
      id: "job",
      title: "직업 입력하기",
      description: "어떤 일을 하는지 알려주세요",
      percentageBoost: 10,
      sfSymbol: "briefcase.fill",
      check: { !$0.job.isEmpty }
    ),
    .init(
      id: "qa",
      title: "프로필 문답 작성하기",
      description: "재미있는 질문에 답해보세요",
      percentageBoost: 10,
      sfSymbol: "questionmark.bubble.fill",
      check: { _ in false }
    ),
    .init(
      id: "verify",
      title: "본인 인증하기",
      description: "인증으로 신뢰를 높여보세요",
      percentageBoost: 8,
      sfSymbol: "checkmark.seal.fill",
      check: { $0.isVerified }
    ),
    .init(
      id: "mbti",
      title: "MBTI 입력하기",
      description: "성격 유형을 공유해보세요",
      percentageBoost: 5,
      sfSymbol: "brain.head.profile",
      check: { !$0.mbti.isEmpty }
    ),
  ]
}
