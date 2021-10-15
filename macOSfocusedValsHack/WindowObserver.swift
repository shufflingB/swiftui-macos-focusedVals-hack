//
//  WindowObserver.swift
//  WindowObserver
///
/// This code is is from Lost Moa's blog post https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/
///

import SwiftUI

class WindowObserver: ObservableObject {
    @Published public private(set) var isKeyWindow: Bool = false

    private var becomeKeyobserver: NSObjectProtocol?
    private var resignKeyobserver: NSObjectProtocol?

    weak var window: Window? {
        didSet {
            isKeyWindow = window?.isKeyWindow ?? false
            guard let window = window else {
                becomeKeyobserver = nil
                resignKeyobserver = nil
                return
            }

            becomeKeyobserver = NotificationCenter.default.addObserver(
                forName: Window.didBecomeKeyNotification,
                object: window,
                queue: .main
            ) { _ in
                self.isKeyWindow = true
            }

            resignKeyobserver = NotificationCenter.default.addObserver(
                forName: Window.didResignKeyNotification,
                object: window,
                queue: .main
            ) { _ in
                self.isKeyWindow = false
            }
        }
    }
}
