//
//  ChatRoutePath.swift
//  AppStateInterface
//
//  Created by kim sunchul on 11/26/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation

public enum ChatRoutePath: RoutePathType {
  case chatRoom(idx: String)
}


extension ChatRoutePath: Hashable {

}
