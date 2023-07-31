import ProjectDescription
import EnvironmentPlugin
import ProjectPathPlugin

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectPathType.app.path)",
      "\(ProjectPathType.features(.base).path)"
    ]
)
