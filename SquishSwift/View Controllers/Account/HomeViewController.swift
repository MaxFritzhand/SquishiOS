//
//  HomeViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        whiteText(welcomeText)
        getName()
    }
    
    func getName() {
        let userData = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUser) as! Data
        let user = try? JSONDecoder().decode(User.self, from: userData)
        let userName = user?.name
        userNameText.text = userName
        whiteText(userNameText)
    }

    func setGradientBackground() {
        let colorTop = UIColor(red: 231/255.0, green: 77/255.0, blue: 244/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 213/255.0, green: 80/255.0, blue: 35/255.0, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func whiteText(_ label:UILabel) {
        label.textColor = UIColor.white
    }
    
    @IBAction func proceedBtnTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.findSupporterViewController) as? FindSupporterViewController
//            let vc = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.requestsViewController) as? RequestsViewController
           let navigationController = UINavigationController(rootViewController: vc!)
           navigationController.setNavigationBarHidden(true, animated: true)
           let options: UIView.AnimationOptions = .transitionCrossDissolve
           UIView.transition(with: (self.view.window!), duration: 0.3, options: options, animations: {})
           UIApplication.shared.windows.first?.rootViewController = navigationController
           UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

//    @IBAction func toProfile(_ sender: Any) {
//        let profileViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
//
//         view.window?.rootViewController = profileViewController
//         view.window?.makeKeyAndVisible()
//    }

