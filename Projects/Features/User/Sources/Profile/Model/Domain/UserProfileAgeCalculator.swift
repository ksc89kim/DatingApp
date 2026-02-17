//
//  UserProfileAgeCalculator.swift
//  User
//
//  Created by kim sunchul on 2/13/26.
//

import Foundation

enum UserProfileAgeCalculator {

  // MARK: - Property

  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()

  // MARK: - Method

  static func calculateAge(from birthday: String) -> Int? {
    guard let birthDate = self.dateFormatter.date(from: birthday) else {
      return nil
    }
    let calendar = Calendar.current
    let components = calendar.dateComponents(
      [.year],
      from: birthDate,
      to: Date()
    )
    return components.year
  }
}
