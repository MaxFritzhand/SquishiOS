//
//  DateCell.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/24/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var circledDate: UIView!
    
    override func layoutSubviews() {
      super.layoutSubviews()
      circledDate.layer.cornerRadius = circledDate.frame.size.width/2
    }
    
    
}
