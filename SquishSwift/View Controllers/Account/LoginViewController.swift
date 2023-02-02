//
//  LoginViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

 
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.tintColor = UIColor.lightGray
            emailTextField.setIcon(UIImage(named: "email")!)
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
              passwordTextField.tintColor = UIColor.lightGray
              passwordTextField.setIcon(UIImage(named: "password")!)
          }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    func setUpElements() {
        errorLabel.alpha = 0
        setGradientBackground()
        Utilities.styleHollowButton(loginButton)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        // Goes back to first supporter, have it go back directly to last page
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.landingViewController) as? ViewController
        let navigationController = UINavigationController(rootViewController: vc!)
        navigationController.setNavigationBarHidden(true, animated: true)
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setGradientBackground() {
        let colorBottom = UIColor(red: 248/255.0, green: 108/255.0, blue: 181/255.0, alpha: 1).cgColor
        let colorTop = UIColor(red: 2/255.0, green: 254/255.0, blue: 255/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // TODO: Validate Text Fields
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
  
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let db = Firestore.firestore()
                // switch to seekers when logging in seekers
                db.collection("seekers").whereField("email", isEqualTo: email).getDocuments{ (snapshot, error ) in
                    for document in (snapshot?.documents)! {
                        let id = document.documentID
                        let firstName = document.data()["firstname"] as! String
                        let lastName = document.data()["lastname"] as! String
                        let fullName = firstName + " " + lastName
                        let user = User(email: email, id: id, name: fullName)
                        User.setCurrentUser(user, writeToUserDefaults: true)
                    }
                }

            
                let vc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                let navigationController = UINavigationController(rootViewController: vc!)
                navigationController.setNavigationBarHidden(true, animated: true)
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    
    
    
    // UITextFieldDelegateMethods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



// Initial Approach towards transitioning to new ViewController and setting as RootVC

//let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//self.view.window?.rootViewController = homeViewController
//self.view.window?.makeKeyAndVisible()



// Above code has major caveats: when referencing VC by storyboard ID (constants), it will ignore the fact that it may be embedded within anything. Same for segues to something embedded, destination VC will be embedding controller


// Another approach to transition

// print(self.navigationController)
// self.navigationController?.pushViewController(findSupporterViewController!, animated: true)

