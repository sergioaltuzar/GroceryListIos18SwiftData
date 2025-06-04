//
//  ContentView.swift
//  Grocery List
//
//  Created by Sergio Altuzar on 03/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext)
    private var modelContext
    @Query private var items: [Item]
    
    func addEssentialFoods() {
        modelContext.insert(Item(title: "Pan y mantequilla", isCompleted: false))
        modelContext.insert(Item(title: "Carne molida", isCompleted: true))
        modelContext.insert(Item(title: "Camarones", isCompleted: .random()))
        modelContext.insert(Item(title: "Mayonesa", isCompleted: .random()))
        modelContext.insert(Item(title: "Aceite", isCompleted: .random()))
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title.weight(.light))
                        .padding(.vertical,2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEssentialFoods()
                        } label: {
                            Label("Essentials", systemImage: "carrot")
                        }
                    }
                }
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
                }
            }
        }
    }
}

#Preview("Sample Data") {
    let sampleData: [Item] = [
        Item(title: "Pan y mantequilla", isCompleted: false),
        Item(title: "Carne molida", isCompleted: true),
        Item(title: "Camarones", isCompleted: .random()),
        Item(title: "Mayonesa", isCompleted: .random()),
        Item(title: "Aceite", isCompleted: .random()),
        Item(title: "Huevos", isCompleted: .random())
    ]
    
    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for item in sampleData {
        container.mainContext.insert(item)
    }
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
