//
//  AppointmentService.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/17/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation
import Firebase


struct AppointmentService {
    
    static func addAppointment(requestID: String, seekerName: String, seekerID: String, supporterName: String, supporterID: String, date: String, time: String, concerns: [String]) {
        let db = Firestore.firestore()
        // Save Request ID to locate and remove from both seeker / supporter
        let id = requestID
        // Create Appointment from Request and pull current User(supporter)
        let concerns = concerns
        let time = time
        let date = date
        let supporterName = supporterName
        let supporterID = supporterID
        let seekerName = seekerName
        let seekerID = seekerID
        
        let appointment = Appointment(concerns: concerns, date: date, time: time, supporterName: supporterName, supporterID: supporterID, seekerName: seekerName, seekerID: seekerID)

        let supporterAppointment = [
               "concerns" : appointment.concerns,
               "date" : appointment.date,
               "id": appointment.id,
               "time" : appointment.time,
               "seekerID" : appointment.seekerID,
               "seekerName" : appointment.seekerName
               ] as [String : Any]
        
         let seekerAppointment = [
               "concerns" : appointment.concerns,
               "date" : appointment.date,
               "id": appointment.id,
               "time" : appointment.time,
               "supporterID" : appointment.supporterID,
               "supporterName" : appointment.supporterName
               ] as [String : Any]

        // Add Appt to Supporter
        db.collection("supporters").document(supporterID).updateData([
            "appointments": FieldValue.arrayUnion([
                supporterAppointment
            ])
        ])
        // Add Appt to Seeker
        db.collection("seekers").document(seekerID).updateData([
              "appointments": FieldValue.arrayUnion([
                  seekerAppointment
              ])
          ])
        
        // Remove this initiating request from Supporter Requests
        var updatedRequests = [AnyObject]()
        let supporterRef = db.collection("supporters").document(supporterID)
        supporterRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let requestsArray = document.data()?["requests"] as! Array<NSDictionary>
                let filteredRequests = requestsArray.filter { $0["id"] as! String != id }
                updatedRequests = filteredRequests
            }
        }
        
        // use document reference to inject new requests.
        // code below will res
        supporterRef.setData([
            "requests": updatedRequests
        ])
        
        
        // Remove this initiating request from Seeker Requests
    }
}

