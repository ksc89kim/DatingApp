import ProjectDescription
import EnvironmentPlugin
import ProjectPathPlugin

let workspace = Workspace(
  name: env.name,
    projects: [
      "\(ProjectPathType.features(.main).path)",
      "\(ProjectPathType.features(.onboarding).path)",
      "\(ProjectPathType.features(.user).path)",
      "\(ProjectPathType.features(.appState).path)",
      "\(ProjectPathType.features(.version).path)",
      "\(ProjectPathType.features(.launch).path)",
      "\(ProjectPathType.di.path)",
      "\(ProjectPathType.core.path)",
      "\(ProjectPathType.util.path)",
      "\(ProjectPathType.app.path)"
    ]
)
