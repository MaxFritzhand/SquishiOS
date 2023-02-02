//
//  ScheduleTableViewCell.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/26/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var seekerName: UILabel!
    @IBOutlet weak var apptDate: UILabel!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    var schedule: Schedule! {
        didSet {
            seekerName.text = schedule.name
            apptDate.text = schedule.date
//            let dateFormatter = DateFormatter()
//                       dateFormatter.dateFormat = "HH:mm"
//            startTimeLabel.text = dateFormatter.string(from: schedule.startTime)
//                       endTimeLabel.text = dateFormatter.string(from: schedule.endTime)
        }
    }
    
}
