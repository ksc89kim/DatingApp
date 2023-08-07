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
    .string(
      path: "Projects/Features/\(nameAttribute)/Interface/\(nameAttribute)Interface.swift",
      contents: ""
    ),
    .string(
      path: "Projects/Features/\(nameAttribute)/Sources/\(nameAttribute).swift",
      contents: ""
    ),
    .string(
      path: "Projects/Features/\(nameAttribute)/Testing/\(nameAttribute)Testing.swift",
      contents: ""
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
      templatePath: "Tests.stencil"
    ),
    .directory(
      path: "Projects/Features/\(nameAttribute)",
      sourcePath: "Resources"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/Model/\(nameAttribute)ExampleItem.swift",
      templatePath: "ExampleItem.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/Model/\(nameAttribute)ExampleSection.swift",
      templatePath: "ExampleSection.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/View/\(nameAttribute)ExampleApp.swift",
      templatePath: "ExampleApp.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/View/\(nameAttribute)ContentView.swift",
      templatePath: "ContentView.stencil"
    ),
    .file(
      path: "Projects/Features/\(nameAttribute)/Examples/View/\(nameAttribute)DetailView.swift",
      templatePath: "DetailView.stencil"
    )
  ]
)
