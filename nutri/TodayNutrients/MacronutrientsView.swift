//
//  NutrientsView.swift
//  nutri
//
//  Created by Alex Aichinger on 27/7/24.
//

import SwiftUI

struct MacronutrientsView: View {
    var nutrients: [(String, Double, String)]
    let columns = [
        GridItem(
            .flexible(),
            spacing: 0
        ),
        GridItem(
            .flexible(),
            spacing: 0
        ),
        GridItem(
            .flexible(),
            spacing: 0
        )
    ]
    
    var body: some View {
        VStack {          
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(nutrients, id: \.0) { nutrient in
                    MacronutrientView(name: nutrient.0, amount: nutrient.1, unit: nutrient.2)
                        .frame(width: 200, height: 100)
                }
            }
            .padding() // Padding around the grid
        }
        .frame(maxHeight: .infinity) // Ensures the VStack takes up available space
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    let macronutrients = [
        ("Protein", 25.0, "g"),
        ("Carbs.", 75.0, "g"),
        ("Fats", 30.0, "g"),
        ("Fiber", 10.0, "g"),
        ("Sugar", 20.0, "g"),
        ("Water", 2.0, "L"),
        ("Vitamins", 5.0, "mg"),
        ("Minerals", 10.0, "mg"),
        ("Antioxidants", 3.0, "g")
        // Add more items here to test scrolling
    ]
    MacronutrientsView(nutrients: macronutrients)
}
