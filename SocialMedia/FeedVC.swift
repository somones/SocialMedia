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

class FeedVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataServives.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value)
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        _ = KeychainWrapper.removeObjectForKey(KEY_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignin", sender: nil)
    }
}
