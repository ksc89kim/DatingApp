//
//  UserProfileView.swift
//  User
//
//  Created by kim sunchul on 11/15/25.
//

import SwiftUI
import Util

struct UserProfileView: View {
  var profileImageURL: URL?
  
    var body: some View {
      VStack {
        LoadImage<EmptyView>(url: profileImageURL)
          .aspectRatio(contentMode: .fill)
          .frame(height: 200)
          .clipped()
      }
    }
}

#Preview {
  UserProfileView(profileImageURL: .init(string: "https://randomuser.me/api/portraits/women/1.jpg"))
}
