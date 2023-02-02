//
//  AppointmentDateViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/3/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class AppointmentDateViewController: UIViewController {
    @IBOutlet weak var header: UIView!
    
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


}

