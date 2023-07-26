import ProjectDescription
import ProjectDescriptionHelpers
import ConfigurationPlugin

let configurations: [Configuration] = .default

let project: Project = .init(
  name: "FoodReviewBlog",
  settings: .settings(configurations: configurations),
  schemes: configurations.compactMap { (configuration: Configuration) -> Scheme? in
    guard let target = configuration.target else { return nil }
    return .make(name: "FoodReviewBlog", target: target)
  }
)


