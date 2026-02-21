//
//  MyPageViewModelKey.swift
//  MyPage
//
//  Created by kim sunchul on 2/21/26.
//

import DI

enum MyPageViewModelKey: InjectionKey {
  typealias Value = MyPageViewModel
}


enum MyPageSettingViewModelKey: InjectionKey {
  typealias Value = MyPageSettingViewModel
}
