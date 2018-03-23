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
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapShots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapShots{
                    print("SNAP FEED: \(snapShots)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key,postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    func numberOfSections(in tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int{
       return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
         print("post : \(post.caption)")
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
  
    @IBAction func signOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey : KEY_UID)
        print("KEYCHAIN : Succesfully removed PWd from keychain")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: SIGN_OUT, sender: nil)
        
    }
}
