//
//  Signup+InjectionKey.swift
//  UserInterface
//
//  Created by kim sunchul on 11/14/23.
//  Copyright © 2023 com.tronplay. All rights reserved.
//

import Foundation
import DI
import SwiftUI
import Core

public enum SignupViewKey: InjectionKey {
  public typealias Value = View
}


public enum SignupViewModelKey: InjectionKey {
  public typealias Value = ViewModelType
}


public enum SignupRepositoryTypeKey: InjectionKey {
  public typealias Value = SignupRepositoryType
}
