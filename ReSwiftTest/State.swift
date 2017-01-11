//
//  State.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter


struct AppState: StateType {
    var counterState: CounterState
    var navigationState: NavigationState
}


struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            counterState: CounterReducer().handleAction(action: action, state: state?.counterState),
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState)
        )
    }
    
}
