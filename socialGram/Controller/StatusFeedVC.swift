//
//  StatusFeedVC.swift
//  socialGram
//
//  Created by Sushruth on 3/20/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class StatusFeedVC: UIViewController,UITableViewDelegate ,UITableViewDataSource{

    
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_BASE.observe(.value) { (snapshot) in
            print(snapshot.value)
        }
    }

    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int{
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
  
    @IBAction func signOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey : KEY_UID)
        print("KEYCHAIN : Succesfully removed PWd from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: SIGN_OUT, sender: nil)
        
    }
}
