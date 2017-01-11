//
//  ViewController.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {

    //create a typealias for the data you want to listen to from your state
    typealias mySubState = (count: Int, countBy2: Int)
    
    @IBOutlet weak var lblCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        //subscribe to state changes for the count variable in the counterState reducer
        mainStore.subscribe(self) {
            (
                $0.counterState.count,
                $0.counterState.countBy2
            )
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //unsubscribe to state changes
        mainStore.unsubscribe(self)
    }
    
    
    /**
     Function called when the app state updates, this is where the UI components should be updated
     
     - parameter state: the new state
     - returns: void
    */
    func newState(state: mySubState) {
        lblCount.text = "\(state)"
    }
    
    
    @IBAction func btnDownPressed(_ sender: Any) {
        mainStore.dispatch(
            CounterActionDecrease()
        )
    }
    
    
    @IBAction func btnUpPressed(_ sender: Any) {
        mainStore.dispatch(
            CounterActionIncrease()
        )
    }
    
}

