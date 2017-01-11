//
//  AppDelegate.swift
//  ReSwiftTest
//
//  Created by Nick Zayatz on 1/10/17.
//  Copyright © 2017 Cirtual LLC. All rights reserved.
//

import UIKit
import CoreData
import ReSwift
import ReSwiftRouter


var mainStore = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var router: Router<AppState>!
    var window: UIWindow?
    
    
    var rootViewController: Routable!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let firstVC = UINavigationController()
        rootViewController = firstVC
        
        router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController)) { state in
            state.navigationState
        }
        
        mainStore.dispatch(
            SetRouteAction(["NavigationController", ViewController.identifier, SecondViewController.identifier], animated: false)
        )
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = firstVC
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ReSwiftTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


class RootRoutable: Routable {
    
    var routable: Routable
    
    init(routable: Routable) {
        self.routable = routable
    }
    
    
    /**
     Function called when this View Controller is to have something pushed onto it
     
     - parameter routeElementIdentifier: the identifier of the new VC that is to be displayed
     - parameter animated: a boolean representing whether or not the display should be animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: the new VC that is currently being displayed
     */
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        print("Route Push")
        completionHandler()
        return self.routable
    }
    
    
    /**
     Function called when this View Controller should be displayed from a popped VC
     
     - parameter routeElementIdentifier: the identifier of the element that is being popped
     - parameter animated: a boolean representing whether or not the pop is animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: void
     */
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        
        print("Route Pop")
        completionHandler()
    }
    
    
    /**
     Function called when this View Controllers children is changed
     
     - parameter from: the identifier of the element that is being replaced
     - parameter to: the identifier of the element that is being displayed
     - parameter animated: a boolean representing whether or not the change should be animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: the new VC that is currently being displayed
    */
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        print("Route Change")
        completionHandler()
        return self.routable
    }
    
}


extension UINavigationController: Routable {
    
    
    /**
     Function called when this View Controllers children is changed
     
     - parameter from: the identifier of the element that is being replaced
     - parameter to: the identifier of the element that is being displayed
     - parameter animated: a boolean representing whether or not the change should be animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: the new VC that is currently being displayed
     */
    public func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        print("NavBar Change")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllers = [storyboard.instantiateViewController(withIdentifier: to)];
        completionHandler()
        return self.viewControllers[0] as! Routable
    }
    
    
    /**
     Function called when this View Controller is to have something pushed onto it
     
     - parameter routeElementIdentifier: the identifier of the new VC that is to be displayed
     - parameter animated: a boolean representing whether or not the display should be animated
     - parameter completionHandler: a function to be called once the action is completed
     - returns: the new VC that is currently being displayed
     */
    public func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        print("NavBar Push")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: routeElementIdentifier)
        self.pushViewController(rootVC, animated: animated)
        completionHandler()
        
        return rootVC as! Routable
    }
}
