import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToManifest("../../Plugins/EnvironmentPlugin")),
        .local(path: .relativeToManifest("../../Plugins/ConfigurationPlugin")),
        .local(path: .relativeToManifest("../../Plugins/ProjectPathPlugin")),
        .local(path: .relativeToManifest("../../Plugins/TemplatesPlugin"))
    ]
)
