//
//  User.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 12/14/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import Foundation
// Codable protocol makes user object properly ecnoded as Data later

class User: Codable, Identifiable {
    
    var email: String
    var id: String
    var name: String
    
    init(email: String, id: String, name: String) {
        self.email = email
        self.id = id
        self.name = name
    }
    
    static func setCurrentUser(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
    }
}
    
    

