//
//  macOS12XcodeWorkyTestApp.swift
//  macOS12XcodeWorkyTest
//
//  Created by Jonathan Hume on 10/10/2021.
//

import SwiftUI

@main
struct AppRoot: App {
    
    /// This WindowObserver object is from  https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/
    @StateObject var windowObserver = WindowObserver()

    var body: some Scene {
        WindowGroup {
            ContentsView()
                .environmentObject(windowObserver)
                .modifier(WindowObservationModifier())
        }
        .commands {
            ScientistsCommands()
        }
    }
}
