//
//  UserRegisterJob.swift
//  User
//
//  Created by kim sunchul on 2/14/24.
//  Copyright © 2024 com.tronplay. All rights reserved.
//

import Foundation
import UserInterface

final class UserRegisterSingleSelect: UserRegisterMain {
  
  // MARK: - Property
  
  let title: LocalizedStringResource
  
  let subTitle: LocalizedStringResource?
  
  let key: String
  
  let items: [LocalizedStringResource]
  
  var selection: String?
  
  var isBottomDisable: Bool = false
  
  weak var repository: UserRegisterRepositoryType?
  
  // MARK: - Init
  
  init(
    key: String,
    title: LocalizedStringResource,
    subTitle: LocalizedStringResource? = nil,
    items: [LocalizedStringResource] = [],
    selection: String? = nil
  ) {
    self.selection = selection
    self.key = key
    self.title = title
    self.items = items
    self.subTitle = subTitle
  }
  
  // MARK: - Method
  
  func onAppear() {
    self.isBottomDisable = self.selection == nil
  }
  
  func mergeRequest(_ request: UserRegisterRequest) -> UserRegisterRequest {
    var request = request
    request.singleSelectParameters[self.key] = self.selection
    return request
  }
  
  func updateSelection(_ selection: String) {
    self.selection = selection
    self.isBottomDisable = self.selection == nil
  }
}


// MARK: - Factory

extension UserRegisterSingleSelect {
  
  static var job: UserRegisterSingleSelect {
    return .init(
      key: "job",
      title: "어떤 일을 하고 계시나요?",
      items: [
        "학생",
        "아르바이트",
        "프리랜서",
        "회사원",
        "자영업",
        "전문직",
        "의료직",
        "교육직",
        "금융직",
        "연구, 기술직",
        "공무원",
        "사업가",
        "군인",
        "취업준비중",
        "기타"
      ]
    )
  }
}
