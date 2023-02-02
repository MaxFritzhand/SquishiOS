//
//  SupporterCollectionViewCell.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/10/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

protocol DataCollectionProtocol {
    func passSupporter(indx: Int)
}

class SupporterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var appointmentsCountLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    @IBOutlet var tempProfileImg: UIImageView!
    @IBOutlet var learnMoreButton: UIButton!
    
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    
    @IBAction func learnMore(_ sender: Any) {
        delegate?.passSupporter(indx: (index?.row)!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundImg(tempProfileImg)
        Utilities.styleLearnMoreButton(learnMoreButton)
        
    }
    
    func roundImg(_ image: UIImageView) {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.bounds.width / 2
        image.clipsToBounds = false
     }
  
    
    
    var name : String? {
        didSet {
            self.nameLabel.text = name ?? String()
        }
    }
    
    var rate : String? {
        didSet {
            self.rateLabel.text = rate ?? String()
        }
    }
    
    var apptsCount : String? {
        didSet {
            self.appointmentsCountLabel.text = apptsCount ?? String()
        }
    }
    
    var exp : String? {
        didSet {
            self.experienceLabel.text = exp ?? String()
        }
    }
    
    var supporterID : String? {
        didSet {
            self.supporterID = supporterID ?? String()
        }
    }
    

    
    
}
