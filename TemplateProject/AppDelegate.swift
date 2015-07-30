//
//  AppDelegate.swift
//  Template Project
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    var logoView: UIView!
    //var imageView: UIImageView
    var background: UIColor!

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    Parse.setApplicationId("HAjt03sZmV2JIpeVjGurzSPcVqNTDYijRW3UTH5K",
        clientKey: "dnvNfvVQSAzOhIg7h1KQU7AlfySyVSi8k5Zm0rln")
    
    PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions) //to track statistics
    
    let user = PFUser.currentUser()
    let startViewController: UIViewController;
    
    if user != nil {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("firstScreenViewController") as! UIViewController
    } else {
        let loginViewController = PFLogInViewController()
        loginViewController.fields = .UsernameAndPassword | .LogInButton | .SignUpButton | .PasswordForgotten | .Facebook
        loginViewController.delegate = parseLoginHelper
        loginViewController.signUpController?.delegate = parseLoginHelper
        
        /*loginViewController.logInView?.backgroundColor = UIColor.blueColor()
        loginViewController.logInView?.logo = self.logoView
        background.init(patternImage UIImage(named: "checked_box"))
        logoView.backgroundColor = background*/
        
        //hide image in firstscreenviewcontroller
        
        var logInLogoTitle = UILabel()
        logInLogoTitle.text = "APP"
        
        //background.backgr
        //logInLogoTitle.backgroundColor = background.init(patternImage: UIImage(named: "checked_box")!)
        loginViewController.logInView?.logo = logInLogoTitle
         //var image = UIImage(named: "checked_box")
        //loginViewController.logInView?.logo = image
        //loginViewController.logInView?.facebookButton.d
        
        startViewController = loginViewController
    }
    
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = startViewController;
    self.window?.makeKeyAndVisible()
    
    return true
  }
    
    var parseLoginHelper: ParseLoginHelper!
    
    override init() {
        super.init()
        
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error {
                // 1
                ErrorHandling.defaultErrorHandler(error)
            } else  if let user = user {
                // if login was successful, display the firstScreenViewController
                // 2
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let firstScreenViewController = storyboard.instantiateViewControllerWithIdentifier("firstScreenViewController") as! UIViewController
                // 3
                self.window?.rootViewController!.presentViewController(firstScreenViewController, animated:true, completion:nil)
            }
        }
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


}
