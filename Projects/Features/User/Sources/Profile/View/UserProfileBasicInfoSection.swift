//
//  UserProfileBasicInfoSection.swift
//  User
//
//  Created by kim sunchul on 2/15/26.
//

import SwiftUI
import Util

struct UserProfileBasicInfoSection: View {

  // MARK: - Define

  private enum Metric {
    static let horizontalPadding: CGFloat = 18
    static let sectionSpacing: CGFloat = 16
    static let rowSpacing: CGFloat = 12
    static let rowTopSpacing: CGFloat = 12
    static let iconWidth: CGFloat = 20
  }

  // MARK: - Property

  let age: Int?

  let height: String

  let job: String

  let mbti: String

  var body: some View {
    if self.hasContent {
      VStack(alignment: .leading, spacing: 0) {
        Divider()
          .padding(.vertical, Metric.sectionSpacing)
        Text("기본 정보")
          .systemScaledFont(
            font: .semibold,
            size: 17
          )
          .foregroundStyle(Color(.label))
          .padding(
            .bottom,
            Metric.rowTopSpacing
          )
        VStack(
          alignment: .leading,
          spacing: Metric.rowSpacing
        ) {
          if let age = self.age {
            self.infoRow(
              icon: "person.fill",
              label: "\(age)세"
            )
          }
          if !self.height.isEmpty {
            self.infoRow(
              icon: "ruler.fill",
              label: self.height
            )
          }
          if !self.job.isEmpty {
            self.infoRow(
              icon: "briefcase.fill",
              label: self.job
            )
          }
          if !self.mbti.isEmpty {
            self.infoRow(
              icon: "brain.head.profile",
              label: self.mbti
            )
          }
        }
      }
      .padding(
        .horizontal,
        Metric.horizontalPadding
      )
    }
  }
}


// MARK: - Private

private extension UserProfileBasicInfoSection {

  var hasContent: Bool {
    self.age != nil
      || !self.height.isEmpty
      || !self.job.isEmpty
      || !self.mbti.isEmpty
  }

  func infoRow(
    icon: String,
    label: String
  ) -> some View {
    HStack(spacing: 10) {
      Image(systemName: icon)
        .font(.system(size: 15))
        .foregroundStyle(Color(.secondaryLabel))
        .frame(width: Metric.iconWidth)
      Text(label)
        .systemScaledFont(
          font: .regular,
          size: 15
        )
        .foregroundStyle(Color(.label))
    }
  }
}
