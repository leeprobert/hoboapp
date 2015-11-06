//
//  AppDelegate.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 26/10/2015.
//  Copyright (c) 2015 probert. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: login/registration
    
    func login(){
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            
            print("Current User found! \(currentUser!.username)")
            return
        }
        
        // Login
        
        PFUser.logInWithUsernameInBackground("leeprobert", password:"sm3gh3ad") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                print("Success! Logged in \(user!.username)")
                
            } else {
                
                print(error?.description)
            }
        }
    }

    // MARK: boilerplate

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // load Styles
        StyleManager.sharedInstance.loadStyles()
        StyleManager.sharedInstance.setAppearances()
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("rRThkz5WyrqGRIdycl2I5Ybu6TxFXt5y6Cn5xDOQ",
            clientKey: "Wbpmgl9ZzecV2lm7pfCb3hNbXuxQ3z8ra18gTjhT")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
//        PFUser.logOut() // FORCE THE LOGIN SCREEN
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // TODO: learn Swift quick!

}

