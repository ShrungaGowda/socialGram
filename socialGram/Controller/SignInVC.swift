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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //App used saved PWD in Keychain to login as soon as app starts - To early to do this in ViewDidLoad so added here ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: SIGN_IN_SEG, sender: nil)
        }
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
                //Save pwd in KeyChain
                if let user = user{
                    self.completeSignIn(id:user.uid)
                }
            }
        }
    }
    
    //Email Authentication - (FireBase documentation)
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text{
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil{
                    print("Email LOGIN : User authenticated with FireBase")
                    //Save pwd in KeyChain
                    if let user = user{
                       self.completeSignIn(id:user.uid)
                    }
                }else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("LOGIN ERROR : Unable to Create Login")
                        }else{
                            print("LOGIN SUCCESSFUL : Sucessfully Created account and authenticated")
                           //Save pwd in KeyChain
                            if let user = user{
                                self.completeSignIn(id:user.uid)
                            }
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id : String){
        KeychainWrapper.standard.set(id,forKey:KEY_UID)
        print("KEY CHAIN : Successfully saved PWD")
        performSegue(withIdentifier: SIGN_IN_SEG, sender: nil)
    }
}

