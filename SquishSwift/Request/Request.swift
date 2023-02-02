//
//  Request.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation

class Request {
    var id: String
    var concerns: [String]
    var date: String
    var time: String
    var seekerName: String
    var seekerID: String
    var supporterName: String?
    var supporterID: String
    var accepted: Bool
    
    init(concerns: [String], date: String, time: String, seekerName: String, seekerID: String, supporterName: String, supporterID: String) {
        let uid = UUID()
        self.concerns = concerns
        self.date = date
        self.time = time
        self.seekerName = seekerName
        self.seekerID = seekerID
        self.supporterName = supporterName
        self.supporterID = supporterID
        self.accepted = false
        self.id = uid.uuidString
    }
    
    // initializer for populating requests
    init(id: String, concerns: [String], date: String, time: String, seekerName: String, seekerID: String, supporterName: String?, supporterID: String) {
        self.id = id
        self.concerns = concerns
        self.date = date
        self.time = time
        self.seekerName = seekerName
        self.seekerID = seekerID
        self.supporterName = supporterName
        self.supporterID = supporterID
        self.accepted = false
    }
}
