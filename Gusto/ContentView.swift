//
//  ContentView.swift
//  Gusto
//
//  Created by Robert Martinez on 12/15/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = SortDescriptor(\Restaurant.name)
    @State private var navPath = [Restaurant]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $navPath) {
            RestaurantListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Dishology")
                .navigationDestination(for: Restaurant.self) { restaurant in
                    EditRestaurantView(restaurant: restaurant)
                }
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    
                    Button(action: addNewRestaurant) {
                        Label("Add New Restraurant", systemImage: "plus")
                    }
                    
                    Menu("Sort") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Restaurant.name))
                            
                            Text("Price")
                                .tag(SortDescriptor(\Restaurant.priceRating, order: .reverse))
                            
                            Text("Quality")
                                .tag(SortDescriptor(\Restaurant.qualityRating, order: .reverse))
                            
                            Text("Speed")
                                .tag(SortDescriptor(\Restaurant.speedRating, order: .reverse))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    

    func addSamples() {
        try? modelContext.delete(model: Restaurant.self)
        
        let a = Restaurant(name: "The Golden Fork", priceRating: 5, qualityRating: 4, speedRating: 3, note: "A fine dining restaurant with a focus on contemporary global cuisine.", phoneNumber: " (555) 123-4567")
        let b = Restaurant(name: "Blue Ocean Sushi", priceRating: 3, qualityRating: 4, speedRating: 2, note: "Specializing in fresh sushi and Japanese dishes.", phoneNumber: "(555) 234-5678")
        let c = Restaurant(name: "Harvest Moon Cafe", priceRating: 4, qualityRating: 4, speedRating: 2, note: "A cozy spot offering organic and locally sourced comfort food.", phoneNumber: "(555) 345-6789")
        let d = Restaurant(name: "Spice Symphony", priceRating: 3, qualityRating: 4, speedRating: 5, note: "An Indian restaurant known for its vibrant flavors and innovative dishes.", phoneNumber: "(555) 456-7890")
        let e = Restaurant(name: "Rustic Table", priceRating: 5, qualityRating: 2, speedRating: 5, note: "Serving hearty, rustic dishes inspired by traditional American and European countryside recipes.", phoneNumber: "(555) 567-8901")

        let f = Restaurant(name: "Bella Pasta", priceRating: 2, qualityRating: 3, speedRating: 4, note: "A family-owned italian restaurant with a focus on homemade pasta and classic dishes.", phoneNumber: "(555) 678-9012")

        let g = Restaurant(name: "Garden of Vegan", priceRating: 5, qualityRating: 2, speedRating: 2, note: "A plant-based restaurant offering creative vegan versions of popular dishes.", phoneNumber: "(555) 789-0123")

        let h = Restaurant(name: "Cafe Parisien", priceRating: 4, qualityRating: 5, speedRating: 3, note: "A french Cafe and bistro with a selection of pastries, coffees, and class french meals.", phoneNumber: "(555) 890-1234")

        let i = Restaurant(name: "Dragon's Breath BBQ", priceRating: 4, qualityRating: 2, speedRating: 5, note: "A barbeque spot known for its smoky flabors and innovative takes on traditional BBQ.", phoneNumber: "(555) 901-2345")

        let j = Restaurant(name: "Saffron and Sage", priceRating: 4, qualityRating: 1, speedRating: 3, note: "A health-focused eatery that blends Mediterranean and Middle Eastern cuisine with a modern twist.", phoneNumber: "(555) 012-3456")

        modelContext.insert(a)
        modelContext.insert(b)
        modelContext.insert(c)
        modelContext.insert(d)
        modelContext.insert(e)
        modelContext.insert(f)
        modelContext.insert(g)
        modelContext.insert(h)
        modelContext.insert(i)
        modelContext.insert(j)
    }
    
    
    
    func addNewRestaurant() {
        let restaurant = Restaurant(name: "", priceRating: 4, qualityRating: 4, speedRating: 4, note: "", phoneNumber: "123-467-6493")
        modelContext.insert(restaurant)
        
        navPath = [restaurant]
    }
}

#Preview {
    ContentView()
}
