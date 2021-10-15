//
//  FocusedValues.swift
//  FocusedValues
//
//  Created by Jonathan Hume on 12/10/2021.
//

import SwiftUI

struct MyKey: FocusedValueKey {
    typealias Value = Binding<String>
}

extension FocusedValues {
    // MARK: Hack that is being used to stop the focused value being set incorrectly when the window sending it is not the keyWindow

    static let KEY_WINDOW_IS_FALSE_VALUE_HACK = "__ignore__this_value_as_not_sent_from_a_key_window__"

    var scientist: MyKey.Value? {
        get { self[MyKey.self] }
        set {
            guard newValue?.wrappedValue != self[MyKey.self]?.wrappedValue else {
                // print("Ignoring as same as last value")
                return
            }
            guard newValue?.wrappedValue != Self.KEY_WINDOW_IS_FALSE_VALUE_HACK else {
                // print("Ignoring as from non-key-window")
                return
            }
            // print("Setting \(String(describing: newValue))")
            self[MyKey.self] = newValue
        }
    }
}
