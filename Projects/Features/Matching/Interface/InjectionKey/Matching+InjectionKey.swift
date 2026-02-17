//
//  Matching+InjectionKey.swift
//  MatchingInterface
//
//  Created by claude on 2/17/26.
//

import DI
import SwiftUI
import Core

public enum MatchingHomeViewKey: InjectionKey {
  public typealias Value = View
}


public enum MatchingRepositoryTypeKey: InjectionKey {
  public typealias Value = MatchingRepositoryType
}


public enum MatchingCardViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}
