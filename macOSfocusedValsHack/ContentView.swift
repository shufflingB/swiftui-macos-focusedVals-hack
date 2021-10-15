//
//  ContentView.swift
//  macOS12XcodeWorkyTest
//
//  Created by Jonathan Hume on 10/10/2021.
//

import Combine
import SwiftUI

struct OtherView: View {
    @FocusedBinding(\.scientist) var focusedScientist: String?
    var body: some View {
        TextField(
            "OtherView",
            text: Binding(
                get: {
                    focusedScientist ?? "No focusedScientist"
                },
                set: { newValue in
                    focusedScientist = newValue
                }),

            prompt: Text("Enter text in ContentView")
        )
        .help("This is a @FocusedBinding that can rx and update focused(Scene)Values set in the ContentView"
        )
    }
}

struct ContentsView: View {
    @Environment(\.isKeyWindow) var isKeyWindow: Bool

    @State var scientist: String = ""
    @State var localIsKeyWindow: Bool = false

    var body: some View {
        VStack {
            Form {
                OtherView()

                TextField("ContentView", text: $scientist, prompt: Text("Enter text here"))
                    .focusedSceneValue(\.scientist, Binding(
                        get: {
                            localIsKeyWindow ? scientist : FocusedValues.KEY_WINDOW_IS_FALSE_VALUE_HACK
                        },
                        set: { newValue in
                            scientist = newValue
                        }
                    ))
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
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                scientist = [
                    "Curie", "Bell Burnell", "Meitner", "Hodgkin", "Franklin", "Herschel",
                    "Charpentier", "Doudna",
                ]
                .randomElement() ?? "Bogus - something's gone very wrong and bad"
            }
        })
        .onChange(of: isKeyWindow) { newValue in
            print("Got change of isKeyWindow = \(newValue)")
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    localIsKeyWindow = newValue
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    localIsKeyWindow = newValue
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
    }
}
