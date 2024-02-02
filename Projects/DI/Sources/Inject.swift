import Foundation

@propertyWrapper
public final class Inject<Value> {

  // MARK: - Property

  private let lazyValue: (() -> Value)
  
  private var storage: Value?

  public var wrappedValue: Value {
    get {
      if let storage = self.storage {
        return storage
      } else {
        let lazyValue = self.lazyValue()
        self.storage = lazyValue
        return lazyValue
      }
    }
    set {
      self.storage = newValue
    }
  }

  // MARK: - Init

  public init<Key: InjectionKey>(_ key: Key.Type) where Value == Key.Value {
    self.lazyValue = {
      key.currentValue
    }
  }
}
