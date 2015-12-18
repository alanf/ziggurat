# Ziggurat Example App

This is a (spartan) example app to illustrate the components of a [Ziggurat app architecture](https://corner.squareup.com/2015/12/ziggurat-ios-app-architecture.html) and how they fit together. This app architecture is being used at Square to improve testability and prevent massive view controllers.

This app only does one thing, which is add a pre-computed discount amount to a cart.

This simple app is very similar to the original app I wrote to test if this app architecture is feasible, and to give the idea tangible form.

Since the inital prototype, we've grown an app that uses the Ziggurat architecture to over 69,000 lines of Swift code.

### Components in more depth

- A `Service` contains most of the app’s business logic and is the only layer that can mutate underlying state. This separation guarantees immutability at all subsequent layers. It can trigger I/O, as well as parse input. It may also communicate with other `Service`s.
- A `Repository` wraps I/O details so they don’t permeate the rest of the app.
- A `Presenter` queries the `Service` objects to generate a `ViewModel`. It has no state.
- A `ViewModel` is passed into a `ViewController` in order to update it. It is an immutable struct which contains simple types.
- A `ViewController` manages a view hierarchy and responds to user actions, as in Cocoa. In accordance with a one-way data flow, `ViewController`s cannot query other objects, instead, they are updated with new data when it is available through `update()`.
- A `View` is appearance-centric, and owned and managed by a `ViewController`, as in Cocoa.
- A `Renderer` listens to signals that state has changed, and coordinates the app update.
- The `Context` is a lazy object graph, used for dependency injection, and is owned by the `AppDelegate`.
