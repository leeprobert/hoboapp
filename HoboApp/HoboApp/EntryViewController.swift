//
//  ViewController.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 26/10/2015.
//  Copyright (c) 2015 probert. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class EntryViewController: UIViewController, PFLogInViewControllerDelegate {
    
    var loginViewController = PFLogInViewController()
    
    private func presentLogin() {
        
        loginViewController.delegate = self
        loginViewController.fields = [  PFLogInFields.UsernameAndPassword,
                                        PFLogInFields.LogInButton,
                                        PFLogInFields.SignUpButton,
                                        PFLogInFields.PasswordForgotten,
                                        PFLogInFields.Facebook,
                                        PFLogInFields.Twitter]
        
        loginViewController.facebookPermissions = [ "friends_about_me" ]
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: Boilerplate ------------------------------------------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if !loginViewController.isViewLoaded() && PFUser.currentUser() == nil {
            
            presentLogin()
            
        }else if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("authenticatedSegue", sender: self)
        }
    }
    
    // MARK: login delegate -------------------------
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        
        print(error?.description)
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        print("Checking login \(username)")
        
        // TODO: form validation here
        return true
    }
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        
        print("Success login \(user.username)")
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            self.performSegueWithIdentifier("authenticatedSegue", sender: self)
        }
    }
}

