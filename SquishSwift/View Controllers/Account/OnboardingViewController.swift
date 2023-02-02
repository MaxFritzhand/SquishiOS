//
//  OnboardingViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/21/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class OnboardingViewController: ViewController {
    
    
    @IBOutlet weak var onboardingAvatar: UIImageView!
    
    @IBOutlet weak var universityTextField: UITextField! {
        didSet {
              universityTextField.tintColor = UIColor.lightGray
               universityTextField.setIcon(UIImage(named: "college")!)
          }
    }
    @IBOutlet weak var graduationTextField: UITextField! {
        didSet {
              graduationTextField.tintColor = UIColor.lightGray
               graduationTextField.setIcon(UIImage(named: "graduation")!)
          }
    }
    @IBOutlet weak var phoneNumberTextField: UITextField! {
        didSet {
              phoneNumberTextField.tintColor = UIColor.lightGray
               phoneNumberTextField.setIcon(UIImage(named: "phone")!)
          }
    }
    @IBOutlet weak var zipcodeTextField: UITextField! {
        didSet {
              zipcodeTextField.tintColor = UIColor.lightGray
               zipcodeTextField.setIcon(UIImage(named: "zipcode")!)
          }
    }
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        setGradientBackground()
        makeRounded(onboardingAvatar)
    }
    
    override func setGradientBackground() {
        let colorBottom = UIColor(red: 231/255.0, green: 77/255.0, blue: 100/255.0, alpha: 1).cgColor
        let colorTop = UIColor(red: 116/255.0, green: 39/255.0, blue: 122/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    override func setUpElements() {
        // Hide the Error Label
        errorLabel.alpha = 0
        // Element Styling
        Utilities.styleHollowButton(finishButton)
        whiteText(errorLabel)
    }
    
    func validateFields() -> String? {
        if phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            zipcodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            return "Please fill in all fields."
        } else {
            return nil
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
//            let university = universityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let graduation = graduationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let zipcode = zipcodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            self.transitionToHome()
        }
    }
    
 func makeRounded(_ image: UIImageView) {
     image.layer.borderWidth = 1
     image.layer.masksToBounds = false
     image.layer.borderColor = UIColor.black.cgColor
     image.layer.cornerRadius = image.frame.height/2
     image.clipsToBounds = true
 }
    
    func showError(_ message:String) {
           errorLabel.text = message
           errorLabel.alpha = 1
       }
    
    func transitionToHome() {
         
         let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
    
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
         
     }

}
