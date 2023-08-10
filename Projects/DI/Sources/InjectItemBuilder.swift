import Foundation

@resultBuilder
public struct InjectItemBuilder {

  public static func buildBlock(_ components: InjectItem...) -> [InjectItem] {
    return components
  }

  public static func buildBlock(_ component: InjectItem) -> InjectItem {
    return component
  }
}
