//
//  ForgotPasswordViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/19/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: ViewController {
    @IBOutlet weak var bgEllipseOne: UIImageView!
    @IBOutlet weak var bgEllipseTwo: UIImageView!
    
    @IBOutlet weak var sendResetLink: UIButton!
    @IBOutlet weak var forgotPasswordContent: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
        forgotPasswordContent.layer.zPosition = 1
        bgEllipseOne.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
    }
    
    override func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleFbButton(sendResetLink)
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please Fill In All Fields"
        }
        return nil
    }
    
    @IBAction func tappedSendRestLink(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            self.showError(error!)
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(resetFailedAlert, animated: true, completion: nil)
            } else {
                let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                 resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(resetEmailSentAlert, animated: true, completion: nil)
                if resetEmailSentAlert != nil {
                    self.toLanding()
                }
            }
        }
        }
    }
 
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func toLanding() {
        let landingViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.landingViewController) as? ViewController
        
        view.window?.rootViewController = landingViewController
        view.window?.makeKeyAndVisible()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
