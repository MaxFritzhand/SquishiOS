//
//  SupporterTableViewCell.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/10/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import Firebase

class SupporterTableViewCell: UITableViewCell {
    @IBOutlet var supporterCollectionView: UICollectionView! {
        didSet {
            self.supporterCollectionView.delegate = self
            self.supporterCollectionView.dataSource = self
        }
    }
    
//    var parent: UIViewController?
//    var navVC: UINavigationController?
//    var navigationController: UINavigationController?
    
    var parentView: UIView?
    var supporters = [Supporter]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        FinderService.supporters() { (supporters) in 
            self.supporters = supporters
            self.supporterCollectionView.reloadData()
          }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}




extension SupporterTableViewCell : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supporters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SupporterCollectionViewCell", for: indexPath) as? SupporterCollectionViewCell
        
        cell!.supporterID = supporters[indexPath.row].ID
        cell!.name = supporters[indexPath.row].firstName
        cell!.rate = supporters[indexPath.row].rate
        cell!.apptsCount = supporters[indexPath.row].appointmentsCount
        cell!.exp = supporters[indexPath.row].experience
        cell!.index = indexPath
        cell!.delegate = self
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: supporterCollectionView.frame.width, height: supporterCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension SupporterTableViewCell : DataCollectionProtocol {
    func passSupporter(indx: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RequestSupporterVC") as? RequestSupporterViewController
        vc?.supporterID = supporters[indx].ID
        vc?.supporterName = supporters[indx].name
        vc?.supporterFirstName = supporters[indx].firstName
        vc?.rate = supporters[indx].rate
        vc?.appointmentsCount = supporters[indx].appointmentsCount
        vc?.experience = supporters[indx].experience
//        vc?.email = supporters[indx].email
        
//        print(self.parent?.navigationController)
        
        let navigationController = UINavigationController(rootViewController: vc!)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        UIView.transition(with: ((self.parentView?.window)!), duration: 0.3, options: options, animations: {})
         
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}


//    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//
//    self.view.window?.rootViewController = homeViewController
//    self.view.window?.makeKeyAndVisible()
//}


// Old Approach towards moving from TableViewCell -> RequestSupporterVC
//        self.parent?.navigationController?.pushViewController(vc!, animated: true)
//        let navigationController = UINavigationController(rootViewController: vc!)
//        self.navVC?.pushViewController(navigationController, animated: true)
