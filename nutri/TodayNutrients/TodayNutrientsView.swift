//
//  TodayNutrientsView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI
import SwiftData

struct TodayNutrientsView: View {
    @Environment(TodayNutritionViewModel.self) private var vm
    @Environment(\.modelContext) private var modelContext
    @Query private var nutritionData: [NutritionData]
    
    // Define the grid layout with a flexible number of columns
    let columns = [
        GridItem(.adaptive(minimum: 150)) // Adjust the minimum width as needed
    ]

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                Text("Macronutrients")
                    .font(.largeTitle)
                    .padding()
                MacronutrientsView(
                    nutrients: vm.getMacros(nutrients: nutritionData.first)
                )
                .padding(0)
                
                Text("Micronutrients")
                    .font(.largeTitle)
                    .padding()
                MicronutrientsView(
                    nutrients: vm.getMicros(nutrients: nutritionData.first)
                )
                .padding(0)
            }
        }
        .frame(maxHeight: .infinity) // Ensures the VStack takes up available space
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    TodayNutrientsView()
        .environment(TodayNutritionViewModel())
        .modelContainer(previewContainer)
}

@MainActor
let previewContainer: ModelContainer = {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NutritionData.self, configurations: config)
    
    let macro = MacroNutrients(
        carbohydrates: 75.0,
        carbohydratesUnit: "g",
        energyKcal: 200.0,
        fat: 30.0,
        fatUnit: "g",
        fiber: 10.0,
        fiberUnit: "g",
        proteins: 25.0,
        proteinsUnit: "g",
        salt: 1.5,
        saltUnit: "g",
        saturatedFat: 10.0,
        saturatedFatUnit: "g",
        sodium: 1.2,
        sodiumUnit: "g",
        sugars: 20.0,
        sugarsUnit: "g"
    )
    let microNutrients = MicroNutrients(
        alcohol: 0.0,
        betaCarotene: 0.0,
        calcium: 100.0,
        cholesterol: 50.0,
        copper: 0.9,
        fructose: 5.0,
        galactose: 4.0,
        glucose: 8.0,
        iodine: 0.1,
        iron: 14.0,
        lactose: 6.0,
        magnesium: 150.0,
        maltose: 3.0,
        manganese: 2.0,
        pantothenicAcid: 5.0,
        phosphorus: 200.0,
        phylloquinone: 0.05,
        polyols: 2.0,
        potassium: 400.0,
        selenium: 0.05,
        starch: 30.0,
        sucrose: 10.0,
        vitaminA: 900.0,
        vitaminB12: 2.4,
        vitaminB: 1.1,
        vitaminB2: 1.3,
        vitaminB6: 1.3,
        vitaminB9: 400.0,
        vitaminC: 90.0,
        vitaminD: 20.0,
        vitaminE: 15.0,
        vitaminPp: 16.0,
        water: 2.0,
        zinc: 11.0,
        caffeine: 0.0
    )
    let nutritionData = NutritionData(
        macroNutrients: macro,
        microNutrients: microNutrients
    )
    container.mainContext.insert(nutritionData)
    return container
}()
