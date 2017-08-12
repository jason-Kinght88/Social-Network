//
//  FeedVC.swift
//  Social Network
//
//  Created by Amy on 11/8/17.
//  Copyright © 2017 Jason Knight. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
