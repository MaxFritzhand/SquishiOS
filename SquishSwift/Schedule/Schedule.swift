//
//  Schedule.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/26/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit

struct Schedule {
    var name: String
    var date: String
//    var date: Date
//    var startTime: Date
//    var endTime: Date
//    var avatar: UIImageView
}

extension Schedule {
    init(startDate: String, seekerName: String) {
        date = startDate
        name = seekerName
    }
}

extension Schedule : Comparable {
    static func <(lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.date < rhs.date
    }
}

//extension Schedule {
//    init(fromStartDate: Date) {
//        seeker = ["Derek Bullard", "Max Fritzhand", "John Lang", "Andrew Hong"].randomElement()!
//        date = ["07-Nov-2019", "15-Nov-2019", "26-Nov-2019", "20-Dec-2019"].random()!
////       categoryColor = [.red, .orange, .purple, .blue, .black].randomValue()
//
//        let day = [Int](0...27).randomElement()
//        let hour = [Int](0...23).randomElement()
//        let startDate = Calendar.current.date(byAdding: .day, value: day, to: fromStartDate)!
//
//
//        startTime = Calendar.current.date(byAdding: .hour, value: hour, to: startDate)!
//        endTime = Calendar.current.date(byAdding: .hour, value: 1, to: startTime)!
//    }
//}
//
//extension Schedule : Equatable {
//    static func ==(lhs: Schedule, rhs: Schedule) -> Bool {
//        return lhs.startTime == rhs.startTime
//    }
//}
//
//extension Schedule : Comparable {
//    static func <(lhs: Schedule, rhs: Schedule) -> Bool {
//        return lhs.startTime < rhs.startTime
//    }
//}



//calendarDataSource = [
//       "07-Nov-2019": "Onboarding",
//       "15-Nov-2019": "Interview with Max",
//       "26-Nov-2019": "Debug with Derek",
//       "20-Dec-2019": "Meet with John",
//   ]
