//
//  GustoApp.swift
//  Gusto
//
//  Created by Robert Martinez on 12/15/23.
//

import SwiftData
import SwiftUI

@main
struct GustoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Restaurant.self)
    }
}
