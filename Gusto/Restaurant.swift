//
//  Restaurant.swift
//  Gusto
//
//  Created by Robert Martinez on 12/15/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Restaurant {
    var name: String = ""
    var priceRating: Int = 3
    var qualityRating: Int = 3
    var speedRating: Int = 3
    var note: String = ""
    var phoneNumber: String = ""
    var image: Data?
//    var category: Category
//    var selectedCategory = Category.restaurant

    var overallRating: Double {
        let avg = Double(priceRating + qualityRating + speedRating) / 3.0
        return (avg * 10).rounded() / 10
    }

    @Relationship(deleteRule:.cascade, inverse: \Dish.restaurant) var dishes: [Dish]?
    
    var unwrappedDishes: [Dish] {
        dishes ?? []
    }

    enum Category: String, CaseIterable {
        case fastfood, restaurant, dessert
    }

    init(name: String, priceRating: Int, qualityRating: Int, speedRating: Int, note: String, phoneNumber: String) {
        self.name = name
        self.priceRating = priceRating
        self.qualityRating = qualityRating
        self.speedRating = speedRating
        self.dishes = []
        self.note = note
        self.phoneNumber = phoneNumber
    }
}
