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

class StatusFeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    @IBAction func signOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey : KEY_UID)
        print("KEYCHAIN : Succesfully removed PWd from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: SIGN_OUT, sender: nil)
        
    }
}
