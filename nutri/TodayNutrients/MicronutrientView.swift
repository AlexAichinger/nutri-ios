//
//  MicronutrientsView.swift
//  nutri
//
//  Created by Alex Aichinger on 27/7/24.
//

import SwiftUI

struct MicronutrientView: View {
    var name: String
    var amount: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(String(format: "%.1f", amount))
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
    MicronutrientView(name: "Vitamin D", amount: 10)
}
