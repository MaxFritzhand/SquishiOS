//
//  RequestService.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth.FIRUser

// BUILD CURRENT USER FEATURE WHICH WILL MAINTAIN EASY ACCESS TO USER OBJECT WITH ID
// WILL BE HELPFUL LATER IN ACCESSING A CURRENT USER's REQUESTS, APPTS, etc.
// Use this struct to pull requests for a specific user

struct RequestService {
    
    static func sendRequest(supporterID: String, supporterName: String) {
        let db = Firestore.firestore()
        // Create Request and Pull Current User
        let defaults = UserDefaults.standard
        let seekerData = defaults.object(forKey: Constants.UserDefaults.currentUser) as! Data
        let seeker = try? JSONDecoder().decode(User.self, from: seekerData)
        // let seekerEmail = seeker?.email
        let seekerID = seeker?.id
        let seekerName = seeker?.name
        let supporterID = supporterID
        let supporterName = supporterName
        let concerns = ["Anxiety", "Depression"]
        let date = "1/5/20"
        let time = "8:00pm"
    
        let request = Request(concerns: concerns, date: date, time: time, seekerName: seekerName!, seekerID: seekerID!, supporterName: supporterName, supporterID: supporterID)
        
        let supporterRequest = [
            "accepted" : request.accepted,
            "concerns" : request.concerns,
            "date" : request.date,
            "id": request.id,
            "time" : request.time,
            "seekerID" : request.seekerID,
            "seekerName" : request.seekerName
            ] as [String : Any]
        
        let seekerRequest = [
            "accepted" : request.accepted,
            "concerns" : request.concerns,
            "date" : request.date,
            "id": request.id,
            "time" : request.time,
            "supporterID" : request.supporterID,
            "supporterName" : request.supporterName
            ] as [String : Any]
        
        // Add Request to Supporter
        db.collection("supporters").document(supporterID).updateData([
            "requests": FieldValue.arrayUnion([
                supporterRequest
            ])
        ])
        // Add Request to Seeker
        db.collection("seekers").document(seekerID!).updateData([
                  "requests": FieldValue.arrayUnion([
                      seekerRequest
                  ])
              ])
    }
    
    // This function is in context of fetching requests of a supporter, must configure 2-way code to account for both sides. For supporters, difference is that there are accept / decline options where as for seekers they will only see pending status label.
    // figure out name parts of both seeker and supporter and haviang it populate when nil
    static func requests(completion: @escaping ([Request]) -> Void) {
        var requests = [Any]()
        let defaults = UserDefaults.standard
        let supporterData = defaults.object(forKey: Constants.UserDefaults.currentUser) as! Data
        let supporter = try? JSONDecoder().decode(User.self, from: supporterData)
        let supporterID = supporter?.id
        let supporterName = supporter?.name

        let db = Firestore.firestore()
        let supporterRef = db.collection("supporters").document(supporterID!)
        supporterRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let requestsArray = document.data()?["requests"] as! Array<NSDictionary>
                for item in requestsArray {
                    let id = item["id"] as! String
                    let concerns = item["concerns"] as! [String]
                    let date = item["date"] as! String
                    let time = item["time"] as! String
                    let seekerName = item["seekerName"] as! String
                    let seekerID = item["seekerID"] as! String
//                    let supporterID = item["supporterID"] as! String
//                    let supporterName = item["supporterName"] as? String
                    let request = Request(id: id, concerns: concerns, date: date, time: time, seekerName: seekerName, seekerID: seekerID, supporterName: supporterName, supporterID: supporterID!)
                    requests.append(request)
                    completion(requests as! [Request])
                }
            }
        }
    }
}





































//        db.collection("supporters").document(supporter).setData([
//            "requests" : [
//                "accepted" : request.accepted,
//                "concerns": request.concerns,
//                "date" : request.date,
//                "time" : request.time,
//                "seeker" : request.seeker
//            ]
//        ], merge: true)
    
        
        // Add Request to Seeker
//        db.collection("seekers").document(seekerID!).setData([
//            "requests" : [
//                "accepted" : request.accepted,
//                "concerns" : request.concerns,
//                "date" : request.date,
//                "time" : request.time,
//                "supporter" : request.supporter
//            ]
//        ], merge: true)
//
//        let seekerRef = db.collection("seekers").document(seekerID!)
//        seekerRef.updateData([
//            "requests": FieldValue.arrayUnion([])
//        ])

//static func findUser(email: String, completion: @escaping ((String) -> Void)) {
//    var seeker = ""
//    let db = Firestore.firestore().collection("seekers")
//    db.whereField("email", isEqualTo: email).getDocuments() { (querySnapshot, err) in
//        for document in querySnapshot!.documents {
//            let seekerID = document.documentID
//            seeker = seekerID
//            completion(seeker)
//        }
//
//    }
//}
