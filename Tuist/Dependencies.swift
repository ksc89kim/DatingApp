import ProjectDescription
import ConfigurationPlugin
import EnvironmentPlugin

let dependencies = Dependencies(
  swiftPackageManager: .init(
    [
      .remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .exact(.init(15, 0, 3))
      ),
      .remote(
        url: "https://github.com/davdroman/swiftui-navigation-transitions.git",
        requirement: .exact(.init(0, 13, 3))
      ),
      .remote(
        url: "https://github.com/onevcat/Kingfisher.git",
        requirement: .exact(.init(7, 10, 0))
      )
    ],
    baseSettings: .settings(configurations: .default)
  ),
  platforms: [.iOS]
)
