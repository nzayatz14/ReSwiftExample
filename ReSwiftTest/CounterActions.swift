//
//  CounterActions.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import Foundation
import ReSwift


//NOTE: Any Payloads for the action must be passed in and/or calculated in the init() function
//There are no payloads in these incrementors so nothing is passed in

//Action called to increase the counter
struct CounterActionIncrease: Action {
    static let type = "COUNTER_ACTION_INCREASE"
    init() {
    
    }
}

//Action called to decrease the counter
struct CounterActionDecrease: Action {
    static let type = "COUNTER_ACTION_DECREASE"
    init() {
    
    }
}
