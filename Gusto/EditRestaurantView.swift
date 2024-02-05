//
//  EditRestaurantView.swift
//  Gusto
//
//  Created by Robert Martinez on 12/16/23.
//

import SwiftData
import SwiftUI
import PhotosUI

struct EditRestaurantView: View {
    @Bindable var restaurant: Restaurant

    @State private var showingAddDishAlert = false
    @State private var dishName = ""
    @State private var dishReview = ""

    @State private var selectedPhoto: PhotosPickerItem?

    var body: some View {
        Form {

            TextField("Name of restaurant", text: $restaurant.name)


            Section("Ratings") {
                Picker("Price", selection: $restaurant.priceRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }

                Picker("Quality", selection: $restaurant.qualityRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }

                Picker("Speed", selection: $restaurant.speedRating) {
                    ForEach(0..<6) { i in
                        Text(String(i))
                    }
                }

                Text("Overall rating \(String(format: "%.1f", restaurant.overallRating))")

                //                Picker("Category", selection: $restaurant.selectedCategory) {
                //                    ForEach(Restaurant.Category.allCases, id: \.self) { category in
                //                        Text(category.rawValue).tag(category)
                //                    }
                //                }
            }

            Section("Dishes") {
                if restaurant.unwrappedDishes.isEmpty {
                    Text("No dishes. Add a dish to get started.")
                        .foregroundStyle(.gray)
                } else {
                    List {
                        ForEach(restaurant.unwrappedDishes) { dish in
                            HStack {
                                Text(dish.name)

                                Spacer()

                                Text(dish.review)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }

            Section("Phone Number") {
                TextField("Phone Number", text: $restaurant.phoneNumber)
                    .keyboardType(.decimalPad)

            }

            Section("Notes") {
                TextField("Leave a note about the restaurant.", text: $restaurant.note, axis: .vertical)
                    .foregroundStyle(.gray)
            }

            Section("Photo") {

                if let imageData = restaurant.image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }

                PhotosPicker(selection: $selectedPhoto,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Label("Add Image", systemImage: "photo")
                }

                if restaurant.image != nil {
                    Button(role: .destructive) {
                        withAnimation {
                            selectedPhoto = nil
                            restaurant.image = nil
                        }
                    } label: {
                        Label("Remove Image", systemImage: "xmark")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
        .toolbar {
            Button("Add Dish") {
                showingAddDishAlert.toggle()
            }
        }
        .alert("Add a new dish", isPresented: $showingAddDishAlert) {
            TextField("Dish name", text: $dishName)
            TextField("Dish review", text: $dishReview)

            Button("OK", action: createDish)
            Button("Cancel", role: .cancel) { }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                restaurant.image = data
            }
        }
    }

    func createDish() {
        let dish = Dish(name: dishName, review: dishReview)
        restaurant.dishes?.append(dish)

        dishName = ""
        dishReview = ""
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Restaurant.self, configurations: config)

        let restaurant = Restaurant(name: "Bun Voyage", priceRating: 1, qualityRating: 3, speedRating: 3, note: "Note Example", phoneNumber: "123-456-7963")

        return EditRestaurantView(restaurant: restaurant)
            .modelContainer(container)
    } catch {
        return Text("Failed to create a model container")
    }
}
