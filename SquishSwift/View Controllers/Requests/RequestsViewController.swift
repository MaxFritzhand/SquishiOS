//
//  RequestsViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/15/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {
    @IBOutlet var header: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var requests = [Request]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderBackground(header)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipe(sender:)))
        view.addGestureRecognizer(rightSwipe)
        RequestService.requests() { (requests) in
            self.requests = requests
            self.collectionView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
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

extension RequestsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requests.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCell", for: indexPath) as? RequestCollectionViewCell
        cell!.contentView.layer.cornerRadius = 15
        cell!.contentView.layer.borderWidth = 1.0
        cell!.contentView.layer.borderColor = UIColor.white.cgColor
        cell!.contentView.layer.masksToBounds = true
        cell!.name = requests[indexPath.row].seekerName
        cell!.date = requests[indexPath.row].date
        cell!.time = requests[indexPath.row].time
        cell!.requestID = requests[indexPath.row].id
        cell!.seekerID = requests[indexPath.row].seekerID
        cell!.supporterID = requests[indexPath.row].supporterID
        cell!.supporterName = requests[indexPath.row].supporterName ?? ""
        cell!.requestConcerns = requests[indexPath.row].concerns
        return cell!
    }
}

