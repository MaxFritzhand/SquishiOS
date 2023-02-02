//
//  SignUpViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var signUpHeader: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.tintColor = UIColor.lightGray
             firstNameTextField.setIcon(UIImage(named: "user")!)
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.tintColor = UIColor.lightGray
            lastNameTextField.setIcon(UIImage(named: "user")!)
        }
    }
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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setGradientBackground()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleHollowButton(signUpButton)
        whiteText(signUpHeader)
    }
    
    
    // Validate Input Fields, if everything valid returns nil
    // Otherwise, it returns the error message in errorLabel
    func validateFields() -> String? {
        // Check that all fields are filled in
        // Remove all white spaces and new lines from text field and check if empty
        // If Empty, return error message " Please fill in field"
        // Using .text? (optional chaining) because could be nil ( not filled in )
        // trimmingCharacters removes all whitespaces and new lines
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    // Sign Up Button
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate The Fields
        let error = validateFields()
        // If there was an error
        if error != nil {
            // Show error message
            showError(error!)
        } else {
            // Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            print("hello")
            // Create The User
            // Callback gets run after user is created, need bc we must know if user creation was successful
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                print(err as Any)
                if err != nil {
                    // err.localizedDescription (contains string containing error description
                    // Up to your discretion in how to show error
                    // If in here, there was an error
                    self.showError("Error creating User")
                } else {
                    // User was created successful, now store text data and initialize basic user db model
                    // Gives us access to Firestore object and methods (1:27:07)
                    let db = Firestore.firestore()
                    db.collection("supporters").addDocument(data: ["firstname":firstName, "lastname":lastName, "email":email, "uid": result!.user.uid, "appointments": [], "requests": []]) { (error) in
                        if error != nil {
                            self.showError("Error saving User Data")
                        } else {
                            self.transitionToOnboarding()
                        }
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func whiteText(_ label:UILabel) {
        label.textColor = UIColor.white
    }
    
    func transitionToOnboarding() {
        let onboardingViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.onboardingViewController) as? OnboardingViewController
        view.window?.rootViewController = onboardingViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    // UITextFieldDelegateMethods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                         CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                         CGRect(x: 20, y: 0, width: 40, height: 30))
          iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
