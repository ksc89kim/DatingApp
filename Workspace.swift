import ProjectDescription
import EnvironmentPlugin
import ProjectPathPlugin

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectPathType.features(.version).path)",
      "\(ProjectPathType.features(.launch).path)",
      "\(ProjectPathType.di.path)",
      "\(ProjectPathType.core.path)",
      "\(ProjectPathType.app.path)"
    ]
)
