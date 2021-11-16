#  macOSfocusedValsHack

This app demonstrates one way to hack around what I believe are bugs in the way the `focusedSceneValue` and `focusedValue` and their `@FocusedValue` and `@FocusedBinding` wrappers are currently working on the **`macOS`** platform.

Hopefully the hack will be redundant shortly ...

## The problem
### macOS @ 2021/11/61
- on macOS Monterey 12.0.1 (21A5552a)
- with Xcode  13.1

Then with default approaches similar to those suggested by [Apple](https://developer.apple.com/documentation/swiftui/view/focusedscenevalue(_:_:)),  [Swift with Majid](https://swiftwithmajid.com/2021/03/03/focusedvalue-and-focusedbinding-property-wrappers-in-swiftui/)  etc, on `macOS` I see what I think are two, possibly related, problems.



#### Fails to restore state when window becomes keyWindow
When the user clicks out of the app's [keyWindow](https://developer.apple.com/documentation/appkit/nsapplication/1428406-keywindow) onto another app, or another window from the same app i.e. moves keyWindow status elsewhere away from the original window. Then, when they subsequently click back onto the original window I.e. move the keyWindow back, `focusedSceneValues` and `focusedValues` are not being restored to what they were before click out.



#### Commands context @FocusedValue/@FocusedBinding gets updated with non-keyWindow values
Alongside the correct values from the keyWindow, values from other non-keyWindows are being received by `@FocusedBinding` and `@FocusedValue` in the menu `Commands` view builder context.


### Form more infomation

- [https://openradar.appspot.com/FB9163579](https://openradar.appspot.com/FB9163579)
- [https://openradar.appspot.com/FB9703748](https://openradar.appspot.com/FB9703748)
- [https://developer.apple.com/forums/thread/693580](https://developer.apple.com/forums/thread/693580) 

## The workaround
The workaround relies on using a `WindowObserver` class from Lost Moas blog post [here](https://lostmoa.com/blog/ReadingTheCurrentWindowInANewSwiftUILifecycleApp/) to  add an `Environment` `isKeyWindow` to the `WindowGroup` scene instance. And to then use that to update an AppModel that
shares the canonical value across the application when the keyWindow changes.



### To compile and run demo app
Needs macOS Monterey and a version of Xcode capable of building project such as Xcode  13.0 beta 5.
 
1. Run on macOS:
1. Use `File-> New window`, or default `Cmd+n` to open multiple windows.
2. Click on other apps, or different window from this app to move `keyWindow` to a different Window. 

## Notes
1. Kudos to Lost Moa for the excellent, particularly for macOS, [blog posts](https://lostmoa.com/blog/).
