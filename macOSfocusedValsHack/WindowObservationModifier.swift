//
//  WindowObservationModifier.swift
//  WindowObservationModifier
///
/// This code is is from Lost Moa's blog post https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/
///

import SwiftUI


struct WindowObservationModifier: ViewModifier {
    @StateObject var windowObserver: WindowObserver = WindowObserver()
    
    func body(content: Content) -> some View {
        content.background(
            HostingWindowFinder { [weak windowObserver] window in
                windowObserver?.window = window
            }
        ).environment(\.isKeyWindow, windowObserver.isKeyWindow)
    }
}
