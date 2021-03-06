//
//  ViewController.swift
//  CountriesTask
//
//  Created by Marwan Ihab on 5/26/19.
//  Copyright © 2019 Marwan Ihab. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import  SVProgressHUD

class ViewController: UIViewController , GIDSignInUIDelegate,  GIDSignInDelegate {
   
    
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GIDSignIn.sharedInstance().clientID = "891939526132-rv06rqi25236m5llaiorgncug0ve54v0.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        if (AccessToken.current != nil) || (Auth.auth().currentUser != nil)  {
          
            performSegue(withIdentifier: "goToHome", sender: self)
            
        }
        
    }
    
    @IBAction func gLoginPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        SVProgressHUD.show()

        if let error = error {
            SVProgressHUD.dismiss()
            print("erro is found\(error)")
            return
        }
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                SVProgressHUD.dismiss()
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            else{

                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
            
            
            
        }
        
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let fbLoginManager = LoginManager()
        
        
        
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
             SVProgressHUD.show()
            
            if result?.isCancelled == true {
                SVProgressHUD.dismiss()
            }
            
            if let error = error {
                 SVProgressHUD.dismiss()
                print("Failed to login: \(error.localizedDescription)")
                
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
           
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                
                
                if let error = error {
                    SVProgressHUD.dismiss()
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                else{

                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
                
                
                
            }
        }
    }
    
    


    @IBAction func LoginPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                SVProgressHUD.dismiss()

                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
            else{
                SVProgressHUD.dismiss()
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func signUP(_ sender: UIButton) {

        performSegue(withIdentifier: "goTosignup", sender: self)
    }
}

