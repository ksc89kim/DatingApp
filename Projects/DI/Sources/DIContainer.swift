import Foundation

public final class DIContainer {

  // MARK: - Property

  public static var instance: DIContainer = .init()
  
  private var items: [String: InjectItem] = [:]

  // MARK: - Method
  
  public static func resolve<T>(for type: Any.Type?) -> T {
    let name = type.map { (type: Any.Type) -> String in
      return String(describing: type)
    } ?? String(describing: T.self)

    guard let injectable = self.instance.items[name]?.resolve() as? T else {
      fatalError("Dependency \(T.self) not resolved")
    }
    return injectable
  }

  public static func register(@InjectItemBuilder _ items: () -> [InjectItem]) {
    items().forEach { (item: InjectItem) in
      self.instance.add(item)
    }
  }

  public static func register(@InjectItemBuilder _ item: () -> InjectItem) {
    self.instance.add(item())
  }

  public func add(_ item: InjectItem) {
    self.items[item.name] = item
  }
}
