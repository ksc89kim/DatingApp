import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies(swiftPackageManager: [
  .remote(
    url: "https://github.com/Moya/Moya.git",
    requirement: .exact(.init(15, 0, 3))
  )
])
