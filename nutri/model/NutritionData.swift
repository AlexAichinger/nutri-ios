//
//  NutritionData.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation
import SwiftData

struct MacroNutrients: Codable {
    var carbohydrates: Double?
    var carbohydratesUnit: String?
    var energyKcal: Double?
    var fat: Double?
    var fatUnit: String?
    var fiber: Double?
    var fiberUnit: String?
    var proteins: Double?
    var proteinsUnit: String?
    var salt: Double?
    var saltUnit: String?
    var saturatedFat: Double?
    var saturatedFatUnit: String?
    var sodium: Double?
    var sodiumUnit: String?
    var sugars: Double?
    var sugarsUnit: String?
}

struct MicroNutrients: Codable {
    var alcohol: Double?
    var betaCarotene: Double?
    var calcium: Double?
    var cholesterol: Double?
    var copper: Double?
    var fructose: Double?
    var galactose: Double?
    var glucose: Double?
    var iodine: Double?
    var iron: Double?
    var lactose: Double?
    var magnesium: Double?
    var maltose: Double?
    var manganese: Double?
    var pantothenicAcid: Double?
    var phosphorus: Double?
    var phylloquinone: Double?
    var polyols: Double?
    var potassium: Double?
    var selenium: Double?
    var starch: Double?
    var sucrose: Double?
    var vitaminA: Double?
    var vitaminB12: Double?
    var vitaminB: Double?
    var vitaminB2: Double?
    var vitaminB6: Double?
    var vitaminB9: Double?
    var vitaminC: Double?
    var vitaminD: Double?
    var vitaminE: Double?
    var vitaminPp: Double?
    var water: Double?
    var zinc: Double?
    var caffeine: Double?
}

@Model
class NutritionData {
    @Attribute(.unique) var id = UUID()
    var lastUpdated: Date
    var macroNutrients: MacroNutrients
    var microNutrients: MicroNutrients
    
    init(macroNutrients: MacroNutrients, microNutrients: MicroNutrients) {
        self.lastUpdated = Date()
        self.macroNutrients = macroNutrients
        self.microNutrients = microNutrients
    }
}
