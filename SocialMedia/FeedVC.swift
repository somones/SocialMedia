//
//  FeedVC.swift
//  SocialMedia
//
//  Created by Samir Belkahla on 02/11/2017.
//  Copyright © 2017 Samir Belkahla. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signOutTapped(_ sender: Any) {
        _ = KeychainWrapper.removeObjectForKey(KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignin", sender: nil)
    }
}
