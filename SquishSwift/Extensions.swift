//
//  Extensions.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/26/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit


public extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if categories[key] == nil {
                categories[key] = [element]
            }
            else {
                categories[key]?.append(element)
            }
        }
        
        return categories
    }
}
