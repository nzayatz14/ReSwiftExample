//
//  ViewController.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class ViewController: UIViewController, StoreSubscriber, Routable {
    
    //Identifier for routing
    static let identifier = "ViewController"
    
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
    
    
    //MARK: ReSwift Callbacks
    
    
    /**
     Function called when the app state updates, this is where the UI components should be updated
     
     - parameter state: the new state
     - returns: void
     */
    func newState(state: mySubState) {
        lblCount.text = "\(state)"
    }
    
    
    /**
     Function called when this View Controller is to have something pushed onto it
     
     - parameter routeElementIdentifier: the identifier of the new VC that is to be displayed
     - parameter animated: a boolean representing whether or not the display should be animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: the new VC that is currently being displayed
    */
    public func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == "SecondViewController" {
            let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            self.navigationController?.pushViewController(secondVC, animated: animated)
            completionHandler()
            return secondVC as Routable
        }
        
        return self
    }
    
    
    /**
     Function called when this View Controller should be displayed from a popped VC
     
     - parameter routeElementIdentifier: the identifier of the element that is being popped
     - parameter animated: a boolean representing whether or not the pop is animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: void
    */
    public func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        
        print(routeElementIdentifier)
        completionHandler()
    }
    
    
    //MARK: Button Presses
    
    
    @IBAction func btnNextPressed(_ sender: Any) {
        mainStore.dispatch(
            SetRouteAction(["NavigationController", ViewController.identifier, SecondViewController.identifier])
        )
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

