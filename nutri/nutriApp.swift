//
//  nutriApp.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI
import SwiftData

@main
struct nutriApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            NutritionData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @State var nutriModel = TodayNutritionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(nutriModel)
        .modelContainer(sharedModelContainer)
    }
}
