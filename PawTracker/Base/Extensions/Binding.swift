//
//  Binding.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/04/2023.
//
// SwiftUI TextField with Optional Binding

import SwiftUI

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == T? {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
}
