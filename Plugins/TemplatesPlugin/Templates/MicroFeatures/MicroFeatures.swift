import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let featureKeyAttribute = Template.Attribute.required("key")

private let template = Template(
  description: "MicroFeatures 관련 템플릿입니다.",
  attributes: [
    nameAttribute,
    featureKeyAttribute
  ],
  items: [
    .file(
      path: "Projects/Features/\(nameAttribute)/Project.swift",
      templatePath: "Project.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/\(nameAttribute)ExampleApp.swift",
      templatePath: "ExampleApp.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Interface/\(nameAttribute)Interface.swift",
      templatePath: "EmptyFile.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Sources/\(nameAttribute).swift",
      templatePath: "EmptyFile.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Testing/\(nameAttribute)Testing.swift",
      templatePath: "EmptyFile.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
      templatePath: "Tests.stencil"
    ),
    .directory(
      path: "Projects/Features/\(nameAttribute)", sourcePath: "Resources")
  ]
)
