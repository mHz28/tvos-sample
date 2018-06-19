//
//  AppDelegate.swift
//  Project4
//
//  Created by Stephen DeStefano on 5/18/17.
//  Copyright © 2017 Stephen DeStefano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let categories = ["Business", "Culture", "Sport", "Technology", "Travel"]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //1 - grab the root view controller and safely typecast to be a tab bar controller
        if let tabBarController = window?.rootViewController as? UITabBarController {
            
            //2 - create an empty view controller array to hold the view controllers for our app
            var viewControllers = [UIViewController]()
            
            //3 - loop over all the categories
            for category in categories {
                
                //4 - create a new view controller for this category
                if let newsController = tabBarController.storyboard?.instantiateViewController(withIdentifier: "News") as? ViewController {
                    
                    //5 - give it the title of this category
                    newsController.title = category
                    
                    //6 - append it to our array of view controllers
                    viewControllers.append(newsController)
                }
            }
            viewControllers.append(createSearch(storyboard: tabBarController.storyboard))
            
            //7 - assign the view controller array to the tab bar controller
            tabBarController.viewControllers = viewControllers
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
    }
    
    func createSearch(storyboard: UIStoryboard?) -> UIViewController {
        
        guard let newsController = storyboard?.instantiateViewController(withIdentifier: "News") as? ViewController else { fatalError("Unable to instantiate a NewsController.")
    }
        
        let searchController = UISearchController(searchResultsController: newsController)
        searchController.searchResultsUpdater = newsController
        
        let searchContainer = UISearchContainerViewController(searchController: searchController)
        searchContainer.title = "Search"
        
        return searchContainer
    }
    


}

