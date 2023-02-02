//
//  Appointment.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/17/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation


class Appointment {
    var id: String
    var concerns: [String]
    var date: String
    var time: String
    var supporterName: String
    var supporterID: String
    var seekerName: String
    var seekerID: String
    
    // Initializer for creating appointment
    init(concerns: [String], date: String, time: String, supporterName: String, supporterID: String, seekerName: String, seekerID: String) {
        let uid = UUID()
        self.concerns = concerns
        self.date = date
        self.time = time
        self.supporterName = supporterName
        self.supporterID = supporterID
        self.seekerName = seekerName
        self.seekerID = seekerID
        self.id = uid.uuidString
    }
    
    
    
    
}




