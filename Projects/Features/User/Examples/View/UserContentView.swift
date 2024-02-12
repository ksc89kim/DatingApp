import SwiftUI
@testable import DI
@testable import Core
@testable import User
@testable import UserInterface
@testable import UserTesting
@testable import AppStateInterface

struct UserContentView: View {
  
  // MARK: - Property
  
  let sections: [UserExampleSection] = [
    .examples
  ]
  
  // MARK: - Body
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(self.sections) { section in
          Section(section.name) {
            ForEach(section.items) { item in
              NavigationLink(item.rawValue, value: item)
            }
          }
        }
      }
      .navigationBarTitle("데모", displayMode: .inline)
      .navigationDestination(for: UserExampleItem.self) { item in
        switch item {
        case .signup: 
          SignupView()
        }
      }
      .listStyle(.sidebar)
    }
  }
  
  // MARK: - Init
  
  init() {
    AppStateDIRegister.register()
    let tokenManager: MockTokenManager = .init(token: "TEST")
    DIContainer.register {
      InjectItem(LoginRepositoryTypeKey.self) { MockLoginRepository() }
      InjectItem(LoginKey.self) {
        Login(tokenManager: tokenManager)
      }
      InjectItem(SignupRepositoryTypeKey.self) { MockSignupRepository() }
      InjectItem(SignupViewModelKey.self) { 
        SignupViewModel(
          mains: [SignupNickname()],
          tokenManager: tokenManager
        )
      }
    }
  }
}


#Preview {
  UserContentView()
}
