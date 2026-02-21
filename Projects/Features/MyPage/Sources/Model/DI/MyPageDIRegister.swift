//
//  MyPageDIRegister.swift
//  MyPage
//
//  Created by kim sunchul on 2/19/26.
//

import Foundation
import DI
import MyPageInterface
import Core

public struct MyPageDIRegister {

  // MARK: - Method

  public static func register() {
    DIContainer.register {
      InjectItem(MyPageRepositoryTypeKey.self) {
        MyPageRepository(networking: .init(stub: .immediatelyStub))
      }
      InjectItem(MyPageSettingRepositoryTypeKey.self) {
        MyPageSettingRepository(networking: .init(stub: .immediatelyStub))
      }
      InjectItem(MyPageViewModelKey.self) {
        MyPageViewModel()
      }
      InjectItem(MyPageSettingViewModelKey.self) {
        MyPageSettingViewModel()
      }
    }
  }
}
