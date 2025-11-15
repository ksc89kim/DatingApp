// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    nonisolated(unsafe) let targets: [ConfigurationTarget] = .default

    nonisolated(unsafe) let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:],
        baseSettings: .settings(configurations: targets.configurations)
    )
#endif

nonisolated(unsafe) let package = Package(
    name: "Test",
    dependencies: [
      .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
      .package(url: "https://github.com/davdroman/swiftui-navigation-transitions.git", from: "0.16.1"),
      .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.10.0")
    ]
)
