//
//  UserRegister+InjectionKey.swift
//  UserInterface
//
//  Created by kim sunchul on 2/11/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import DI
import SwiftUI
import Core

public enum UserRegisterViewKey: InjectionKey {
  public typealias Value = View
}


public enum UserRegisterViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}


public enum UserRegisterRepositoryTypeKey: InjectionKey {
  public typealias Value = UserRegisterRepositoryType
}
