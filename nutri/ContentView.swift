//
//  ContentView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = "dashboard"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodayNutrientsView()
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .tag("dahboard")
            Button("Test") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            ScannerView()
                .tabItem {
                    Label("Log Food", systemImage: "camera")
                }
                .tag("scanner")
        }
    }
}

#Preview {
    let nutriModel = TodayNutritionViewModel()
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NutritionData.self, configurations: config)
    ContentView()
        .environment(nutriModel)
        .modelContainer(container)
}
