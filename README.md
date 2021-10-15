#  macOSfocusedValsHack

This app demonstrates one way to hack around what I believe are bugs in the way the `focusedSceneValue` and `focusedValue` and their `@FocusedValue` and `@FocusedBinding` wrappers are currently working on the **`macOS`** platform.

Hopefully the hack will be redundant shortly ...

## The problem
### macOS
- on macOS Monterey 12.0 Beta 12 (21A5552a)
- with Xcode  13.0 beta 5 

Then with default approaches similar to those suggested by [Apple](https://developer.apple.com/documentation/swiftui/view/focusedscenevalue(_:_:)),  [Swift with Majid](https://swiftwithmajid.com/2021/03/03/focusedvalue-and-focusedbinding-property-wrappers-in-swiftui/)  etc, on `macOS` I see what I think are two, possibly related, problems.

#### Fails to restore state when window becomes keyWindow
When the user clicks out of the app's [keyWindow](https://developer.apple.com/documentation/appkit/nsapplication/1428406-keywindow) onto another app, or another window from the same app i.e. moves keyWindow status elsewhere away from the original window. Then, when they subsequently click back onto the original window I.e. move the keyWindow back, `focusedSceneValues` and `focusedValues` are not being restored to what they were before click out.

#### Commands context @FocusedValue/@FocusedBinding gets updated with non-keyWindow values
Alongside the correct values from the keyWindow, values from other non-keyWindows are being received by `@FocusedBinding` and `@FocusedValue` in the menu `Commands` view builder context.

## The workaround
The workaround relies on using a `WindowObserver` class from Lost Moas blog post [here](https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/) to  add an `Environment` `isKeyWindow` to the `WindowGroup` scene instance.

The scene then:

1. Listens for changes in `isKeyWindow` and sets a local copy using differential timing to ensure that the instance where keyWindow is true is set last. This is necessary to ensure that the latest version of the `Commands` menu is correctly generated.
2. Uses a `Binding` and a special value to clear the `focusedValue` when scene is not the `keyWindow`. This is necessary to allow it to restore the value when it becomes the `keyWindow` again.

### To compile and run demo app
Needs macOS Monterey and version of Xcode capable of building for it such as Xcode  13.0 beta 5.

0. Set 
1. Run on macOS:
1. Use `File-> New window`, or default `Cmd+n` to open multiple windows.
2. Click on other apps, or different window from this app to move `keyWindow` to a different Window. 

## Notes
1. Kudos to Lost Moa for the excellent, particularly for macOS, [blog posts](https://lostmoa.com/blog/).

1. My understanding is that `iOS` for iPad also looks like it has related problems e.g. [SO question](https://stackoverflow.com/questions/69555293/focusedvalue-focusedbinding-not-working-on-ipad/69576785#69576785) . As far as I can tell, the problem for `iPad` the `Command` view builder not firing on `@FocusedBinding` update often enough. Whereas the problem on `macOS` is that it's fired too often with the wrong data. Consequently, although I've not tested against this hack, it seems unlikely to be of much help - sorry.


