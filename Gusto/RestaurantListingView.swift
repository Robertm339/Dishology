//
//  RestaurantListingView.swift
//  Gusto
//
//  Created by Robert Martinez on 12/17/23.
//

import SwiftData
import SwiftUI

struct RestaurantListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [
        SortDescriptor(\Restaurant.priceRating, order: .reverse),
        SortDescriptor(\Restaurant.name)
    ]) var restraurants: [Restaurant]
    
    var body: some View {
        List {
            ForEach(restraurants) { restaurant in
                NavigationLink(value: restaurant) {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .padding(.bottom, 2)

                        HStack(spacing: 30) {
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                Text(String(restaurant.priceRating))
                            }
                            
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                Text(String(restaurant.qualityRating))
                            }
                            
                            HStack {
                                Image(systemName: "bolt")
                                Text(String(restaurant.speedRating))
                            }
                        }
                    }
                }
            }
            .onDelete(perform: deleteRestaurants)
        }
        .listStyle(.inset)
    }
    
    init(sort: SortDescriptor<Restaurant>, searchString: String = "") {
        _restraurants = Query(filter: #Predicate {
            if searchString.isEmpty {
                true
            } else {
                $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteRestaurants(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = restraurants[item]
            modelContext.delete(object)
        }
    }
}

#Preview {
    RestaurantListingView(sort: SortDescriptor(\Restaurant.name))
}
