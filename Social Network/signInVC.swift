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

class signInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
        }
    }

}

