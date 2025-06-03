//
//  Grocery_ListApp.swift
//  Grocery List
//
//  Created by Sergio Altuzar on 03/06/25.
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
