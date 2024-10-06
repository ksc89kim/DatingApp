import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectType.app.path)"
    ]
)
