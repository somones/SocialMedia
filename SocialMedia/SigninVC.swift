//
//  SigninVC.swift
//  SocialMedia
//
//  Created by Samir Belkahla on 02/11/2017.
//  Copyright © 2017 Samir Belkahla. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SigninVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebooLogin = FBSDKLoginManager()
        
        facebooLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("BSS: Unable to connecte with facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("BSS: User cancelled Facebook authentification")
            } else {
                print("BSS: Successfully authentified with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth (_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("BSS: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("BSS: Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("BSS: Email user authonticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("BSS: Unable to authenticate with Firebase using email")
                        } else {
                            print("BSS: Successflly authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>){
        DataServives.ds.createFirebaseDBUser(uid: id, userData: userData)
        let KeychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        print("BSS: Data saved to Keychain \(KeychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

