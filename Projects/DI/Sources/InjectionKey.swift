import Foundation

public protocol InjectionKey {
  associatedtype Value
  static var currentValue: Self.Value { get }
}


public extension InjectionKey {

  static var currentValue: Value {
    return DIContainer.resolve(for: Self.self)
  }
}
