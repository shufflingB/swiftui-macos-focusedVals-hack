//
//  AppModel.swift
//  macOSfocusValsPlay
//
//  Created by Jonathan Hume on 16/11/2021.
//

import SwiftUI

class AppModel: ObservableObject {
    @Published private(set) var focusedScientist: String? = nil
    private var currentKeyWindow: UUID?

    func focusedScientistUpdate(_ windowId: UUID, isKeyWindow: Bool, windowsString: String) {
        print("======================")
        print("Window id = \(windowId) - \(windowsString)")
        if isKeyWindow {
            print("is Keywindow")
            print("Setting focusedScientist = \(windowsString)")
            currentKeyWindow = windowId
            focusedScientist = windowsString
        } else if currentKeyWindow == windowId {
            print("Is not Keywindow")
            print("Is no longer key window")
            print("Setting focusedScientist = nil")
            focusedScientist = nil
        }
        objectWillChange.send()
    }
}
