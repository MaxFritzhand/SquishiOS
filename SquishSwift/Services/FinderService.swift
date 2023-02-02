//
//  FinderService.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/9/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth.FIRUser

struct FinderService {
    
    static func supporters(completion: @escaping ([Supporter]) -> Void) {
        var supporters = [Any]()
        let db = Firestore.firestore()
        db.collection("supporters").getDocuments {(snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let supporterID = document.documentID
                    let firstName = document.data()["firstname"] as! String
                    let lastName = document.data()["lastname"] as! String
                    let supporterName = firstName + " " + lastName
                    let supporterEmail = document.data()["email"] as! String
                    let supporterRateInt = document.data()["rate"] as! Int
                    let supporterRateString = String(supporterRateInt)
                    let supporterApptsCount = document.data()["appointmentsCount"] as! Int
                    let apptsCountString = String(supporterApptsCount)
                    let supporterExperience = document.data()["experience"] as! Int
                    let experienceString = String(supporterExperience)
                    let supporter = Supporter(ID: supporterID, name: supporterName, firstName: firstName, emailAddress: supporterEmail, hourlyRate: supporterRateString, apptsCount: apptsCountString, exp: experienceString)
                    supporters.append(supporter)
                    completion(supporters as! [Supporter])
                }
            }
        }
    }
    
}





//    static func supporters(completion: @escaping ([Supporter]) -> Void) {
//          var ref = Database.database().reference().child("supporters") as DatabaseReference?
//        ref!.observe(.value, with:  { snapshot in
//            for child in snapshot.child {
//
//            })
//        }
//    }
//
    
//
//
//    CREATING USER
//    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
//        let userAttrs = ["username": username]
//
//        let ref = Database.database().reference().child("users").child(firUser.uid)
//        ref.setValue(userAttrs) { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return completion(nil)
//            }
//
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let user = User(snapshot: snapshot)
//                completion(user)
//            })
//        }
//    }
    

    
// READING FROM FIREBASE
//    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
//        let ref = Database.database().reference().child("users").child(uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let user = User(snapshot: snapshot) else {
//                return completion(nil)
//            }
//
//            completion(user)
//        })
//    }
    

