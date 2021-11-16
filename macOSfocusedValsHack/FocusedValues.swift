//
//  FocusedValues.swift
//  FocusedValues
//
//  Created by Jonathan Hume on 12/10/2021.
//

import SwiftUI


// MARK: As of Xcode Version 13.1 (13A1030d) FocusedValueKey does not work on macOS, see notes in README
struct MyKey: FocusedValueKey {
    typealias Value = Binding<String>
}

extension FocusedValues {
    var scientist: MyKey.Value? {
        get { self[MyKey.self] }
        set { self[MyKey.self] = newValue }
    }
}
