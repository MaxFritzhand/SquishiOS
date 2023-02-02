//
//  RequestCollectionViewCell.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/15/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class RequestCollectionViewCell: UICollectionViewCell {
    @IBOutlet var requestImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeImage: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var acceptButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    
    // Transfer in Supporter/Seeker ID's and use these to locate users and add appointments to both
    // Remove Request from Both as they are now officially appointments
    var seekerID = ""
    var supporterID = ""
    var supporterName = ""
    var requestID = ""
    var requestConcerns: [String] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundImg(requestImage)
        Utilities.styleAcceptRequestButton(acceptButton)
        Utilities.styleDeclineRequestButton(declineButton)
      }
    
//    var concerns : [String]? {
//        didSet {
//            self.requestConcerns = concerns ?? [String]()
//        }
//    }
    
    var name : String? {
        didSet {
            self.nameLabel.text = name ?? String()
        }
    }
    
    var date : String? {
        didSet {
            self.dateLabel.text = date ?? String()
        }
    }
    
    var time : String? {
        didSet {
            self.timeLabel.text = time ?? String()
        }
    }
    
    @IBAction func tappedAcceptButton(_ sender: Any) {
        showAcceptRequestAlert()
    }
    
    @IBAction func tappedDeclineButton(_ sender: Any) {
        showDeclineRequestAlert()
    }
    
    func showAcceptRequestAlert() {
        let alert = UIAlertController(title: "Accept Request", message: "Would you like to add this appointment", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_) in
            // Add Appointment through Service and create Appointment within there
            AppointmentService.addAppointment(requestID: self.requestID, seekerName: self.name!, seekerID: self.seekerID, supporterName: self.supporterName, supporterID: self.supporterID, date: self.date!, time: self.time!, concerns: self.requestConcerns)
            // Reroute to AppointmentsViewController which should have populated Appointments for
            // both seeker and supporter
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
        //   print ("User clicked Cancel Button")
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: {
         //    print("Alert Completion Block")
         })
    }
    
    func showDeclineRequestAlert() {
        
    }
    
    
    func roundImg(_ image: UIImageView) {
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.purple.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
      }
    
}
