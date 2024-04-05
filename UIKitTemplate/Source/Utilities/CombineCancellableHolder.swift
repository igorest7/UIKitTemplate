import Foundation
import Combine

public protocol CombineCancellableHolder {
    var cancellables: [AnyCancellable] { get set }
}

private struct AssociatedKeys {
    static var Cancellables = "CancellablesName"
}

public extension CombineCancellableHolder where Self: AnyObject {
    var cancellables: [AnyCancellable] {
        get {
            withUnsafePointer(to: &AssociatedKeys.Cancellables) {
                return PropertyStoring.getAssociatedObject(for: self, key: $0) ?? []
            }
        }
        set {
            withUnsafePointer(to: &AssociatedKeys.Cancellables) {
                PropertyStoring.setAssociatedObject(for: self, key: $0, newValue: newValue)
            }
        }
    }
}

fileprivate final class PropertyStoring {
    static func getAssociatedObject<T>(for object: AnyObject, key: UnsafeRawPointer) -> T? {
        objc_getAssociatedObject(object, key) as? T
    }

    static func setAssociatedObject<T>(for object: AnyObject, key: UnsafeRawPointer, newValue: T?) {
        objc_setAssociatedObject(object, key, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
}
