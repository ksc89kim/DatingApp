//
//  MatchingDIRegister.swift
//  Matching
//
//  Created by claude on 2/17/26.
//

import Foundation
import DI
import MatchingInterface

public struct MatchingDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(MatchingRepositoryTypeKey.self) {
        let repository = MatchingRepository(
          networking: .init(stub: .immediatelyStub)
        )
        return repository
      }
      InjectItem(MatchingCardViewModelKey.self) {
        return MatchingCardViewModel()
      }
    }
  }
}
