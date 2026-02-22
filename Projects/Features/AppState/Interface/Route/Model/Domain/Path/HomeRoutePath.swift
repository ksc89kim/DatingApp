//
//  HomeRoutePath.swift
//  AppStateInterface
//
//  Created by claude on 2/21/26.
//

import Foundation

public enum HomeRoutePath: RoutePathType {
  case userProfile(userID: String)
}


extension HomeRoutePath: Hashable {

}
