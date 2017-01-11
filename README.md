# ReSwift Example

Hi Thomas, this is your captain speaking. Not really, this is a pretty simple layout of a sample [ReSwift](https://github.com/ReSwift/ReSwift "Title") app I put together. I'm going to break it down into the various portions of Redux we know and love.

## Store

In the `AppDelegate.swift` file, create an instance of the store above the `AppDelegate` class. A sample will look like this.

```swift
import UIKit
import CoreData
import ReSwift //Import the ReSwift Library

//Create the store Object
var mainStore = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

...

}
```

In this case, the `AppReducer()` object is the reducer that is created when combining all the other reducers. The `state` starts off as `nil` because it will be created upon initial load of the app in the combined reducer struct.

## Actions

In ReSwift, actions each have their own struct which is inherited from a generic `Action` struct created in ReSwift. An example action would look like

```swift
struct CounterActionIncrease: Action {
    static let type = "COUNTER_ACTION_INCREASE"
    var payload: Int!
    
    init(amountToAdd: Int) {
    	payload = amountToAdd
    }
}
```
Any parameters required for the action are passed in via the `init()` function and the payload is created from there.

You will call upon the `mainStore` (created in `AppDelegate`) to dispatch the action.

```swift
mainStore.dispatch(
            CounterActionIncrease(amountToAdd: 2)
        )
```

## Reducers

Reducers in ReSwift also come in struct form. Each Reducer will have a `State` struct for initialization and a `Reducer` struct with a function `func handleAction(action: Action, state: State?) -> State` to handle any actions that are dispatched. A single reducer file will look like this.

```swift
//Initial State for the Counter Reducer
struct CounterState: StateType {
    init(){}
    var count: Int = 0
}


//Counter Reducer that handles actions
struct CounterReducer: Reducer {
    
    //action handler for this reducer
    func handleAction(action: Action, state: CounterState?) -> CounterState {
        
        //create a copy of the state to maintain immutability
        var state = state ?? CounterState()
        
        switch action {
            
        case _ as CounterActionIncrease:
            state.count += action.payload
            return state
            
        default:
            break
            
        }
        
        return state
    }
    
}
```

### Combine Reducers

To combine reducers in ReSwift, you simply create instances of the sub reducers in the main reducer (which I call `AppState`). **Note** there is a combine reducer function that comes with ReSwift, but it does not let you separate the initializers of the reducers. This would become a mess if all of our variables for the entire app were in one struct. I chose to subclass the reducers because it would make data handling cleaner.

The Main reducer is setup exactly like any other reducer. It just has the other reducers as its elements in its initializer struct. Here is an example

```swift
//The Combined Reducer struct (or the state)
struct AppState: StateType {
    var counterState: CounterState
}

//The Reducer for the state that combines the other reducers
struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            counterState: CounterReducer().handleAction(action: action, state: state?.counterState)
        )
    }
    
}
```

When you handle actions in the Main Reducer, simply return a new Instance of the main reducer, with all the parameters of that reducer set to handle the action.

## TODO

I have not yet messed around with [ReSwift's routing framework](https://github.com/ReSwift/ReSwift-Router "Title"), but it seems similar to React-Router so hopefully it will not be terrible.