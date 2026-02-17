//
//  MatchingRoutePath.swift
//  AppStateInterface
//
//  Created by claude on 2/17/26.
//

import Foundation

public enum MatchingRoutePath: RoutePathType {
  case userProfile(userID: String)
}


extension MatchingRoutePath: Hashable {

}
