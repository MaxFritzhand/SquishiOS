//
//  Supporter.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/9/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation
//import FirebaseDatabase.FIRDataSnapshot

class Supporter {
    var ID: String
    var name: String
    var firstName: String
    var email: String
    var rate: String
//    var appointments: String
    var appointmentsCount: String
    var experience: String
    
    init(ID: String, name: String, firstName: String, emailAddress: String, hourlyRate: String, apptsCount: String, exp: String) {
        self.ID = ID
        self.name = name
        self.firstName = firstName
        self.email = emailAddress
        self.rate = "$" + hourlyRate + "/hr"
//        self.appointments = appts
        self.appointmentsCount = apptsCount
        self.experience = exp
    }

    
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String : Any],
//        let firstname = dict["firstname"] as? String
//
//            else { return nil }
//        self.name = firstname
//    }

}



