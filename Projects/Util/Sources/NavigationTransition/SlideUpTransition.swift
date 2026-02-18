//
//  SlideUpTransition.swift
//  Util
//
//  Created by claude on 2/17/26.
//

import NavigationTransition
import AtomicTransition

/// Hinge 스타일 슬라이드업 전환
/// Push: 프로필이 아래에서 올라오고, 배경 카드 스택은 축소 + 페이드
/// Pop: MirrorPush가 자동으로 역방향 처리
public struct SlideUpTransition: NavigationTransitionProtocol {

  public init() {}

  public var body: some NavigationTransitionProtocol {
    MirrorPush {
      OnInsertion {
        ZPosition(1)
        Move(edge: .bottom)
      }
      OnRemoval {
        Scale(0.92)
        Opacity()
      }
    }
  }
}
