import ProjectDescription
import ConfigurationPlugin
import EnvironmentPlugin

let dependencies = Dependencies(
  swiftPackageManager: .init(
    [
      .remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .exact(.init(15, 0, 3))
      )
    ],
    baseSettings: .settings(configurations: .default)
  ),
  platforms: [.iOS]
)
