import Foundation

public struct InjectItem {

  // MARK: - Property

  public let name: String
  
  public let resolve: () -> Injectable

  // MARK: - Init

  public init<T: InjectionKey>(
    _ name: T.Type,
    resolve: @escaping () -> Injectable
  ) {
    self.name = String(describing: name)
    self.resolve = resolve
  }
}
