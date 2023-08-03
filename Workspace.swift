import ProjectDescription
import EnvironmentPlugin
import ProjectPathPlugin

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectPathType.features(.base).path)",
      "\(ProjectPathType.app.path)"
    ]
)
