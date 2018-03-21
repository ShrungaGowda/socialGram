//
//  ViewController.swift
//  socialGram
//
//  Created by Sushruth on 3/14/18.
//  Copyright © 2018 iosDev. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class SignInVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //SIGN IN USING FB LOGIN
    @IBAction func fbSignTapped(_ sender: Any) {
    //Assign login manager
       let fbLogin = FBSDKLoginManager()
    
        fbLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in // login using email (fb)
            if error != nil{                                                            //FB login error
                print("LOGIN ERROR : Unable to authenticate with FB - \(String(describing: error))")
            }else if result?.isCancelled == true {                                      //if user cancells it
                print("LOGIN ERROR : User cancelled FB authentication")
            }else{
                print("LOGIN SUCCESSFUL :  Able to login with  FB")                             //Succesfully loging
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString) //using fb login we get auth token
                self.firebaseAuth(credential)
            }
        }
    }
    
    //Create a generic method (same for GIT/Twitter/Insta using firebase) which takes credentials
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                print("LOGIN ERROR : Unable to login with firebase \(String(describing: error))")
            }else{
                 print("LOGIN SUCCESSFUL : Able to login with firebase")
            }
        }
    }
    
}

