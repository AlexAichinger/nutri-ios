//
//  NutritionView.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import SwiftUI

struct MacronutrientView: View {
    var name: String
    var amount: Double
    var unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(String(format: "%.1f %@", amount, unit))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

#Preview {
    MacronutrientView(name: "Carbs", amount: 50, unit: "g")
}
