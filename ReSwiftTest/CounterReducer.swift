//
//  CounterReducer.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import Foundation
import ReSwift


//Initial State for the Counter Reducer
struct CounterState: StateType {
    init(){}
    var count: Int = 0
    var countBy2: Int = 0
}


//Counter Reducer that handles actions
struct CounterReducer: Reducer {
    
    //action handler for this reducer
    func handleAction(action: Action, state: CounterState?) -> CounterState {
        
        //create a copy of the state to maintain immutability
        var state = state ?? CounterState()
        
        switch action {
            
        case _ as CounterActionIncrease:
            state.count += 1
            state.countBy2 += 2
            return state
            
        case _ as CounterActionDecrease:
            state.count -= 1
            state.countBy2 -= 2
            return state
            
        default:
            break
            
        }
        
        return state
    }
    
}
