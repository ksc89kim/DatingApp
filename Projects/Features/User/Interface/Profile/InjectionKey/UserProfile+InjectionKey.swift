//
//  UserProfile+InjectionKey.swift
//  UserInterface
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation
import SwiftUI
import DI

public enum UserProfileRepositoryTypeKey: InjectionKey {
  public typealias Value = UserProfileRepositoryType
}
