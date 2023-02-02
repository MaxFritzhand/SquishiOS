//
//  RequestSupporterViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/10/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class RequestSupporterViewController: UIViewController {
    @IBOutlet var header: UIView!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var requestButton: UIButton!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var appointmentsCountLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    
    var supporterID = ""
    var supporterName = ""
    var supporterFirstName = ""
    var rate = ""
    var appointmentsCount = ""
    var experience = ""
    // var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBackground(header)
        roundImg(profilePic)
        Utilities.styleRequestButton(requestButton)
        nameLabel.text = supporterFirstName
        rateLabel.text = rate
        appointmentsCountLabel.text = appointmentsCount
        experienceLabel.text = experience
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        // Goes back to first supporter, have it go back directly to last page
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindSupporterVC") as? FindSupporterViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    
    
    func setHeaderBackground(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor(red: 231/255.0, green: 77/255.0, blue: 244/255.0, alpha: 1).cgColor
           let colorBottom = UIColor(red: 116/255.0, green: 39/255.0, blue: 112/255.0, alpha: 1).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundImg(_ image: UIImageView) {
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = CGFloat(roundf(Float(image.frame.size.width / 2.0)))
     }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func tappedRequestButton(_ sender: Any) {
        showRequestAlert()
    }
    
    func showRequestAlert() {
        let alert = UIAlertController(title: "Request Appointment", message: "Would you like to request an appointment?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Request", style: .default, handler: { (_) in
            // Send Request
            RequestService.sendRequest(supporterID: self.supporterID, supporterName: self.supporterName)
            // Reroute to FindSupporterVC
            let vc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.findSupporterViewController) as? FindSupporterViewController
             let navigationController = UINavigationController(rootViewController: vc!)
             navigationController.setNavigationBarHidden(true, animated: true)
             let options: UIView.AnimationOptions = .transitionCrossDissolve
             UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
             UIApplication.shared.windows.first?.rootViewController = navigationController
             UIApplication.shared.windows.first?.makeKeyAndVisible()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
        //   print ("User clicked Cancel Button")
        }))
        self.present(alert, animated: true, completion: {
        //    print("Alert Completion Block")
        })
    }
    


}


