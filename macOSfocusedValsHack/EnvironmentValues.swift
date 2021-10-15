//
//  EnvironmentValues.swift
//  EnvironmentValues
///
/// This code is is from Lost Moa's blog post https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/
///

import SwiftUI

extension EnvironmentValues {
    struct IsKeyWindowKey: EnvironmentKey {
        static var defaultValue: Bool = false
        typealias Value = Bool
    }

    var isKeyWindow: IsKeyWindowKey.Value {
        get {
            self[IsKeyWindowKey.self]
        }
        set {
            self[IsKeyWindowKey.self] = newValue
        }
    }
}
