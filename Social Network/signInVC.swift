//
//  ViewController.swift
//  Social Network
//
//  Created by Amy on 7/8/17.
//  Copyright © 2017 Jason Knight. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class signInVC: UIViewController {
    
    @IBOutlet weak var passwordTxtField: customTextField!
    @IBOutlet weak var emailTxtField: customTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    @IBAction func fbBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                
                print("JASON: Unable to authenticate with Facebook - \(String(describing: error))")
                
            } else if result?.isCancelled == true {
                
                print("JASON: User cancelled authentication")
                
            } else {
                
                print("JASON: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if error != nil {
                print("JASON: Unable to authenticate with firebase - \(String(describing: error))")
                
            } else {
                print("Succesfully authenticated with firebase")
                
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.signInComplete(id: user.uid, userData: userData)
                }
            }
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailTxtField.text, let pwd = passwordTxtField.text {
            
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    print("JASON:  Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.signInComplete(id: user.uid, userData: userData)
                    }
                    
                } else {
                    
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        
                        if error != nil {
                            print("JASON: Unable to authenticate with firebase using email")
                            
                        } else {
                            print("JASON: Successfully authenticated with firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.signInComplete(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func signInComplete(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychaingResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("JASON: Data saved to keychain\(keychaingResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
}

