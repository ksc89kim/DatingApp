//
//  MyPage+InjectionKey.swift
//  MyPageInterface
//
//  Created by kim sunchul on 2/19/26.
//

import DI
import SwiftUI
import Core

public enum MyPageHomeViewKey: InjectionKey {
  public typealias Value = View
}


public enum MyPageRepositoryTypeKey: InjectionKey {
  public typealias Value = MyPageRepositoryType
}


public enum MyPageSettingRepositoryTypeKey: InjectionKey {
  public typealias Value = MyPageSettingRepositoryType
}
