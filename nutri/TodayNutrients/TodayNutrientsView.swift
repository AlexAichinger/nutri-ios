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
            Text("\(macros?.carbohydrates ?? 0)")
                .padding()
                .overlay(Circle().stroke(.blue))
            
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
    TodayNutrientsView()
        .environment(nutriModel)
}
