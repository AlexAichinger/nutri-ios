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
    
    var body: some View {
        let macros = nutritionData.first?.macroNutrients
        HStack {
            Text("carbs")
                .padding()
                .overlay(Circle().stroke(.blue))
//            CircularProgressView(progress: 0.8)
            
            VStack(alignment: .leading) {
                Text("\(macros?.carbohydrates ?? 0)")
                    .bold()
                    .lineLimit(1)
                
                Text("\(macros?.carbohydrates ?? 0)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxHeight: 200)
        .onAppear {
            Task {
                if nutritionData.isEmpty {
                    await vm.getTodaysNutrients(modelContext: modelContext)
                }
            }
        }
    }
}

#Preview {
    let nutriModel = TodayNutritionViewModel()
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: NutritionData.self, configurations: config)
    TodayNutrientsView()
        .environment(nutriModel)
        .modelContainer(container)
}
