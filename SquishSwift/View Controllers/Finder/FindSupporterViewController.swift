//
//  FindSupporterViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/9/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase

class FindSupporterViewController: UIViewController {
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBackground(header)
    }
    
    
    func setHeaderBackground(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        let colorLeft = UIColor(red: 173/255.0, green: 41/255.0, blue: 213/255.0, alpha: 1).cgColor
         let colorRight = UIColor(red: 87/255.0, green: 71/255.0, blue: 213/255.0, alpha: 1).cgColor
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func roundImg(_ image: UIImageView) {
         image.layer.borderWidth = 1
         image.layer.masksToBounds = false
         image.layer.borderColor = UIColor.black.cgColor
         image.layer.cornerRadius = image.frame.height/2
         image.clipsToBounds = true
     }
}






extension FindSupporterViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return supporters.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupporterCell", for: indexPath) as! SupporterTableViewCell
        cell.parentView = self.view
//        cell.parent = self
//        cell.navVC = self.navigationController
//        cell.navigationController = self.navigationController
        return cell
    }
}

extension FindSupporterViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 750
    }
}
