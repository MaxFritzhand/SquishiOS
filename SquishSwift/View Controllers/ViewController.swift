//
//  ViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController{
//    GIDSignInDelegate
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var homeHeader: UILabel!
    @IBOutlet weak var homeSubheader: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
//    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
//        let fbButton = FBLoginButton()
//        fbButton.delegate = self as? LoginButtonDelegate

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    func setUpElements() {
        Utilities.styleHollowButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFbButton(facebookButton)
        setGradientBackground()
        whiteText(homeHeader)
        whiteText(homeSubheader)
    }
    
    func setGradientBackground() {
        let colorTop = UIColor(red: 248/255.0, green: 108/255.0, blue: 181/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 2/255.0, green: 254/255.0, blue: 255/255.0, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
  
    func whiteText(_ label:UILabel) {
        label.textColor = UIColor.white
    }
    
    
    @IBAction func tappedSignUpButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
        
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
           
    }
    
    @IBAction func tappedLoginButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
        
        // Not wrapping with NavVC...
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func tappedFbButton(_ sender: UIButton) {
        //        DARK MODE sUPPORT
                let loginManager = LoginManager()
                loginManager.logIn(permissions: ["public_profile", "email"], from: self ) {(result, error) in
                    if let error = error {
                        print("Failed to login: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let accessToken = AccessToken.current else {
                        print("Failed to get Access Token")
                        return
                    }; if (result?.isCancelled)! {
                        print ("cancel button pressed ")
                        return
                    }
                    
                    // can also access FB info through either accessToken or credential...graphapi
                    let credential = FacebookAuthProvider.credential(withAccessToken:accessToken.tokenString)
                    // Perform Login By Calling Firebase API
                    Auth.auth().signIn(with: credential) { (user, error) in
                        if let error = error {
                            print("Login error: \(error.localizedDescription)")
                            let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alertController.addAction(okayAction)
                            // or display vs present
                            self.present(alertController, animated: true, completion: nil)
                            return
                        }
                        
                        // self.performSegue(withIdentifier: self.signInSegue, sender: nil) (ALT. way to segue from view controllers
                        let db = Firestore.firestore()
                        let currentUser = Auth.auth().currentUser
                        let name = currentUser?.displayName
                        let splitName = name?.components(separatedBy: " ")
                        let firstName = splitName?[0]
                        let lastName = splitName?[1]
                        let email = currentUser?.email
                        let uid = user!.user.uid
        //                print(self)
                        
                        
                        // Check if User Exists
                        db.collection("users").whereField("email", isEqualTo: email!).getDocuments() { (querySnapshot, err) in
                            for document in querySnapshot!.documents {
                                let user = document.data()
        //                       print ("\(document.data())")
        //                       print ("\(user["email"])")
                                let emailCheck = user["email"] as? String
                                if emailCheck == email {
        //                            self.toDashboard()
        //                            self.performSegue(withIdentifier: "ProfileVC", sender: nil)
                                    print ("User Found")
                                    self.toProfile()
                                    return
                                }
                            }
                            db.collection("users").addDocument(data: ["firstname": firstName, "lastname":lastName, "email":email, "uid": uid])
           self.performSegue(withIdentifier: "ProfileVC", sender: nil)
                              print("User Not Found, so created")
                            
                        }
                        
                        // add some sort of error handler here and overall
                        // still need to manage sessions/tokens? implement checks for specific user upon login.
                        // to sign out a user call signOut
        //                    let firebaseAuth = Auth.auth()
        //                do {
        //                  try firebaseAuth.signOut()
        //                } catch let signOutError as NSError {
        //                  print ("Error signing out: %@", signOutError)
        //                }
                    }
                }
            }
    
//    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//       if error != nil {
//           return
//         }
//
//       guard let authentication = user.authentication else { return }
//       let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                           accessToken: authentication.accessToken)
//           Auth.auth().signIn(with: credential) { (user, error) in
//            if error != nil {
//               // ...
//               return
//             }
//             // User is signed in
//               let db = Firestore.firestore()
//               let currentUser = Auth.auth().currentUser
//               let name = currentUser?.displayName
//               let splitName = name?.components(separatedBy: " ")
//               let firstName = splitName?[0]
//               let lastName = splitName?[1]
//               let email = currentUser?.email
//               let uid = currentUser?.uid
//
//               // Check if User Exists
//                db.collection("users").whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
//                   for document in querySnapshot!.documents {
//                       let user = document.data()
//                       let emailCheck = user["email"] as? String
//                       if emailCheck == email {
//                        self.toDashboard()
//                        print ("User Found")
//                        return
//                       }
//                   }
//                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname":lastName, "email":email, "uid": uid])
//                    self.toDashboard()
//                    print("User Not Found, so created")
//                    return
//               }
//           }
//       }
//
//       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//           // Perform any operations when the user disconnects from app here.
//       }
    
  
    
//    func toDashboard() {
//        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
//
//        view.window?.rootViewController = profileViewController
//        view.window?.makeKeyAndVisible()
//    }
    
    func toProfile() {
        let profileViewController = storyboard?.instantiateViewController( identifier: "ProfileVC")
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
}




