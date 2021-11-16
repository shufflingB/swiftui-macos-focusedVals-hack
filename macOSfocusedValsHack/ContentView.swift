//
//  ContentView.swift
//  macOS12XcodeWorkyTest
//
//  Created by Jonathan Hume on 10/10/2021.
//

import Combine
import SwiftUI

struct OtherView: View {
    // MARK: Hack for broken @FocusedBinding

    // Have to replace
    // @FocusedBinding(\.scientist) var focusedScientist: String?
    // with ...
    @EnvironmentObject var appModel: AppModel /// part of hack - Uses a @Published property to share focusedScientist across the complete App
    @Environment(\.isKeyWindow) var isKeyWindow: Bool /// part of hack -  Indicates whether the window hosting the current view is the current keyWindow
    @State var windowId: UUID /// part of hack - Allow each window instance to be uniquely id'd - although never changed, has to be @State or would not be set different
    /// for each window instanct

    var body: some View {
        TextField(
            "Focused Value",
            text: Binding(
                // MARK: Hack for broken @FocusedBinding, s/focusedScientist/appModel.focusedScientist/

                get: {
                    appModel.focusedScientist ?? "No focusedScientist"
                },
                set: { newValue in
                    appModel.focusedScientistUpdate(windowId, isKeyWindow: isKeyWindow, windowsString: newValue)
                }),

            prompt: Text("Enter text in ContentView")
        )
        .help("This is a @FocusedBinding that can rx and update focused(Scene)Values set in the ContentView"
        )
    }
}

struct MainWindow: View {
    // MARK: Hack for broken @FocusedBinding
    // Have to replace
    /// later usage of  .focusedSceneValue(\.scientist, $scientist)
    // with ...
    @EnvironmentObject var appModel: AppModel /// part of hack - Uses a @Published property to share focusedScientist across the complete App
    @Environment(\.isKeyWindow) var isKeyWindow: Bool /// part of hack -  Indicates whether the window hosting the current view is the current keyWindow
    @State var scientist: String = ""
    @State var windowID = UUID()

    var body: some View {
        VStack {
            Form {
                OtherView(windowId: windowID)

                TextField("ContentView", text: $scientist, prompt: Text("Enter text here"))
                    /// .focusedSceneValue(\.scientist, $scientist)
                    .help("With multiple windows, when this window is the keyWindow this TextField updates the 'focusedSceneValue' that OtherView and the Scientists menu uses. NB: focusedSceneValue is independent of if this field has focus or not. To make it dependent on TextField focus, replace focusedSceneValue with focusedValue"
                    )
            }

            Text("Instructions: Click on other apps, or other Windows from this app to move keyWindow status. Use File -> New Window (cmd +n) to create multiple windows")
                .font(.footnote)
        }
        .padding()
        .frame(width: 350, height: 170)
        .navigationTitle("\(isKeyWindow ? "Is app keyWindow" : "Not app keyWindow") (\(scientist))")
        .onAppear(perform: {
            /// Add some data so that when there are multiple windows it's a bit easier to distiguish between them
            scientist = [
                "Curie", "Bell Burnell", "Meitner", "Hodgkin", "Franklin", "Herschel",
                "Charpentier", "Doudna",
            ]
            .randomElement() ?? "Bogus - something's gone very wrong and bad"
            windowID = UUID()
        })
        .onChange(of: isKeyWindow) { newValue in
            appModel.focusedScientistUpdate(windowID, isKeyWindow: newValue, windowsString: scientist)
        }
        .onChange(of: scientist) { newValue in
            appModel.focusedScientistUpdate(windowID, isKeyWindow: isKeyWindow, windowsString: newValue)
        }
    }
}

struct ContentView: View {
    @StateObject var windowObserver = WindowObserver()

    var body: some View {
        MainWindow()
            .environmentObject(windowObserver)
            .modifier(WindowObservationModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainWindow()
    }
}
