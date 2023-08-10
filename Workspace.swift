import ProjectDescription
import EnvironmentPlugin
import ProjectPathPlugin

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectPathType.features(.launch).path)",
      "\(ProjectPathType.di.path)",
      "\(ProjectPathType.app.path)"
    ]
)
