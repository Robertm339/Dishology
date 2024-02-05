//
//  Dish.swift
//  Gusto
//
//  Created by Robert Martinez on 12/17/23.
//

import Foundation
import SwiftData

@Model
class Dish {
    var name: String = ""
    var review: String = ""
    var restaurant: Restaurant?
    
    init(name: String, review: String) {
        self.name = name
        self.review = review
    }
}
