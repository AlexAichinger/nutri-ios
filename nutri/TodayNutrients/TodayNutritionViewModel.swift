//
//  TodayNutritionViewModel.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation
import SwiftData

struct MacroNutrientsDto: Codable {
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

struct MicroNutrientsDto: Codable {
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

struct NutritionDataDto: Codable {
    var macroNutrients: MacroNutrientsDto
    var microNutrients: MicroNutrientsDto
}

extension NutritionDataDto {
    func toModel() -> NutritionData {
        return NutritionData(
            macroNutrients: macroNutrients.toModel(),
            microNutrients: microNutrients.toModel()
        )
    }
}

extension MicroNutrientsDto {
    func toModel() -> MicroNutrients {
        return MicroNutrients(
            alcohol: alcohol,
            betaCarotene: betaCarotene,
            calcium: calcium,
            cholesterol: cholesterol,
            copper: copper,
            fructose: fructose,
            galactose: galactose,
            glucose: glucose,
            iodine: iodine,
            iron: iron,
            lactose: lactose,
            magnesium: magnesium,
            maltose: maltose,
            manganese: manganese,
            pantothenicAcid: pantothenicAcid,
            phosphorus: phosphorus,
            phylloquinone: phylloquinone,
            polyols: polyols,
            potassium: potassium,
            selenium: selenium,
            starch: starch,
            sucrose: sucrose,
            vitaminA: vitaminA,
            vitaminB12: vitaminB12,
            vitaminB: vitaminB,
            vitaminB2: vitaminB2,
            vitaminB6: vitaminB6,
            vitaminB9: vitaminB9,
            vitaminC: vitaminC,
            vitaminD: vitaminD,
            vitaminE: vitaminE,
            vitaminPp: vitaminPp,
            water: water,
            zinc: zinc,
            caffeine: caffeine
        )
    }
}

extension MacroNutrientsDto {
    func toModel() -> MacroNutrients {
        return MacroNutrients(
            carbohydrates: carbohydrates,
            carbohydratesUnit: carbohydratesUnit,
            energyKcal: energyKcal,
            fat: fat,
            fatUnit: fatUnit,
            fiber: fiber,
            fiberUnit: fiberUnit,
            proteins: proteins,
            proteinsUnit: proteinsUnit,
            salt: salt,
            saltUnit: saltUnit,
            saturatedFat: saturatedFat,
            saturatedFatUnit: saturatedFatUnit,
            sodium: sodium,
            sodiumUnit: sodiumUnit,
            sugars: sugars,
            sugarsUnit: sugarsUnit
        )
    }
}

@MainActor
class TodayNutritionViewModel: Observable {
    
    //    MARK - Fetches the nutrients for the specific date
    private func getNutrients(for date: Date, modelContext: ModelContext) async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // remote - http://100.98.35.92:8088
        // local - http://192.168.1.22:8081
        guard let downloadedNutritionStats: NutritionDataDto = await WebService().downloadData(fromURL: "http://100.98.35.92:8088/alexaichinger/macros/\(formatter.string(from: date))") else {return}
        print(downloadedNutritionStats)
        do {
            try modelContext.delete(model: NutritionData.self)
        } catch {
            print("Error deleting old data: \(error)")
        }
        modelContext.insert(downloadedNutritionStats.toModel())
    }
    
    // Transform MacroNutrients properties into a list of (name, value, unit) tuples
    func getMacros(nutrients: NutritionData?) -> [(String, Double, String)] {
        return mapMacronutrients(macroNutrients: nutrients?.macroNutrients)
    }
    
    private func mapMacronutrients(macroNutrients: MacroNutrients?) -> [(String, Double, String)] {
        var list = [(String, Double, String)]()
        
        if let value = macroNutrients?.carbohydrates, let unit = macroNutrients?.carbohydratesUnit {
            list.append(("Carbs", value, unit))
        }
        if let value = macroNutrients?.energyKcal {
            list.append(("Energy", value, "kcal"))
        }
        if let value = macroNutrients?.fat, let unit = macroNutrients?.fatUnit {
            list.append(("Fat", value, unit))
        }
        if let value = macroNutrients?.fiber, let unit = macroNutrients?.fiberUnit {
            list.append(("Fiber", value, unit))
        }
        if let value = macroNutrients?.proteins, let unit = macroNutrients?.proteinsUnit {
            list.append(("Proteins", value, unit))
        }
        if let value = macroNutrients?.salt, let unit = macroNutrients?.saltUnit {
            list.append(("Salt", value, unit))
        }
        if let value = macroNutrients?.saturatedFat, let unit = macroNutrients?.saturatedFatUnit {
            list.append(("Sat. Fat", value, unit))
        }
        if let value = macroNutrients?.sodium, let unit = macroNutrients?.sodiumUnit {
            list.append(("Sodium", value, unit))
        }
        if let value = macroNutrients?.sugars, let unit = macroNutrients?.sugarsUnit {
            list.append(("Sugars", value, unit))
        }
        
        return list
    }
    
    // Transform MacroNutrients properties into a list of (name, value) tuples
    func getMicros(nutrients: NutritionData?) -> [(String, Double)] {
        return mapMicronutrients(microNutrients: nutrients?.microNutrients)
    }
    
    // Transform MicroNutrients properties into a list of (name, value) tuples
    private func mapMicronutrients(microNutrients: MicroNutrients?) -> [(String, Double)] {
        var micros = [(String, Double)]()
        
        // Define nutrient names and map them to their values
        let nutrientMapping: [(String, Double?)] = [
            ("Alcohol", microNutrients?.alcohol),
            ("Beta Carotene", microNutrients?.betaCarotene),
            ("Calcium", microNutrients?.calcium),
            ("Cholesterol", microNutrients?.cholesterol),
            ("Copper", microNutrients?.copper),
            ("Fructose", microNutrients?.fructose),
            ("Galactose", microNutrients?.galactose),
            ("Glucose", microNutrients?.glucose),
            ("Iodine", microNutrients?.iodine),
            ("Iron", microNutrients?.iron),
            ("Lactose", microNutrients?.lactose),
            ("Magnesium", microNutrients?.magnesium),
            ("Maltose", microNutrients?.maltose),
            ("Manganese", microNutrients?.manganese),
            ("Pantothenic Acid", microNutrients?.pantothenicAcid),
            ("Phosphorus", microNutrients?.phosphorus),
            ("Phylloquinone", microNutrients?.phylloquinone),
            ("Polyols", microNutrients?.polyols),
            ("Potassium", microNutrients?.potassium),
            ("Selenium", microNutrients?.selenium),
            ("Starch", microNutrients?.starch),
            ("Sucrose", microNutrients?.sucrose),
            ("Vitamin A", microNutrients?.vitaminA),
            ("Vitamin B12", microNutrients?.vitaminB12),
            ("Vitamin B", microNutrients?.vitaminB),
            ("Vitamin B2", microNutrients?.vitaminB2),
            ("Vitamin B6", microNutrients?.vitaminB6),
            ("Vitamin B9", microNutrients?.vitaminB9),
            ("Vitamin C", microNutrients?.vitaminC),
            ("Vitamin D", microNutrients?.vitaminD),
            ("Vitamin E", microNutrients?.vitaminE),
            ("Vitamin Pp", microNutrients?.vitaminPp),
            ("Water", microNutrients?.water),
            ("Zinc", microNutrients?.zinc),
            ("Caffeine", microNutrients?.caffeine)
        ]
        
        // Filter out nil values
        micros = nutrientMapping.compactMap { nutrient in
            guard let value = nutrient.1 else { return nil }
            return (nutrient.0, value)
        }
        
        return micros
    }
    
    //    MARK - Fetches the nutrients of today
    func getTodaysNutrients(modelContext: ModelContext) async {
        print("Today's Nutrients")
        await getNutrients(for: Date(), modelContext: modelContext)
    }
    
    //    MARK - Handles the interaction for the view to log a meal based on a barcode
    func sendMealLog(mealType: MealType, eatenInGrams: Int, loggingDate: Date, barcode: String) async {
        print("Barcode: \(barcode)")
        let log = AutomaticLogging(
            user: "alexaichinger",
            mealType: mealType.rawValue,
            eatenInGrams: eatenInGrams,
            loggingDate: loggingDate.ISO8601Format(),
            barcode: barcode
        )
        
        // remote - http://100.98.35.92:8088
        // local - http://192.168.1.22:8081
        await WebService().logFood(for: log, fromURL: "http://100.98.35.92:8088/\(log.user)/meals")
    }
}

