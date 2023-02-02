//
//  AppointmentsViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/17/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController {
    @IBOutlet var header: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBackground(header)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        //get appointments
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
      }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.requestsViewController) as? RequestsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setHeaderBackground(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor(red: 231/255.0, green: 77/255.0, blue: 244/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 116/255.0, green: 39/255.0, blue: 122/255.0, alpha: 0.75).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
