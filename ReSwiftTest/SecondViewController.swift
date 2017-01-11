//
//  SecondViewController.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/11/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class SecondViewController: UIViewController, Routable {
    
    //Identifier for routing
    static let identifier = "SecondViewController"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        
        if !(parent != nil) {
            mainStore.dispatch(
                SetRouteAction(["NavigationController", ViewController.identifier])
            )
        }
    }
    
}

