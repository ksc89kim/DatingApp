import Foundation

@propertyWrapper
public final class Inject<Value> {

  // MARK: - Property

  private let lazyValue: (() -> Value)
  
  private var storage: Value?

  public var wrappedValue: Value {
    get {
      self.storage ?? {
        let value: Value = lazyValue()
        self.storage = value
        return value
      }()
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
