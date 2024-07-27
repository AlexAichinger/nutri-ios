//
//  MicroNutrientsView.swift
//  nutri
//
//  Created by Alex Aichinger on 27/7/24.
//

import SwiftUI

struct MicronutrientsView: View {
    var nutrients: [(String, Double)]
    let columns = [
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
                    MicronutrientView(name: nutrient.0, amount: nutrient.1)
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
    let Micronutrients = [
        ("Protein", 25.0),
        ("Carbs.", 75.0),
        ("Fats", 30.0),
        ("Fiber", 10.0),
        ("Sugar", 20.0),
        ("Water", 2.0),
        ("Vitamins", 5.0),
        ("Minerals", 10.0),
        ("Antioxidants", 3.0)
        // Add more items here to test scrolling
    ]
    MicronutrientsView(nutrients: Micronutrients)
}
