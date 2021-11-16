//
//  FooCommands.swift
//  FooCommands
//
//  Created by Jonathan Hume on 12/10/2021.
//

import SwiftUI

struct ScientistsCommands: Commands {
    //@FocusedBinding(\.scientist) var focusedScientist: String?
    @ObservedObject var appModel: AppModel

    var body: some Commands {

        return CommandMenu("Scientists") {
            if let fs =  appModel.focusedScientist, fs != "" {
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
