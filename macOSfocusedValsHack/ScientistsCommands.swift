//
//  FooCommands.swift
//  FooCommands
//
//  Created by Jonathan Hume on 12/10/2021.
//

import SwiftUI

struct ScientistsCommands: Commands {
    @FocusedBinding(\.scientist) var focusedScientist: String?

    var body: some Commands {
        print("\t Building the CommandMenu, focusedText = \(String(describing: focusedScientist))\n")

        return CommandMenu("Scientists") {
            if let fs = focusedScientist, fs != "" {
                Button("Do something with \(fs)") {
                    print("Doing something with \(fs)")
                }
            } else {
                Button("Do something with <selection>") {
                    print("Doing something with nothing")
                }
            }
        }
    }
}
