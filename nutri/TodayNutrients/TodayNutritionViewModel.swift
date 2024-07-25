//
//  TodayNutritionViewModel.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation
import SwiftData

struct MacroNutrientsDto: Codable {
    var carbohydrates: Double
    var carbohydratesUnit: String
    var energyKcal: Double
    var fat: Double
    var fatUnit: String
    var fiber: Double
    var fiberUnit: String
    var proteins: Double
    var proteinsUnit: String
    var salt: Double
    var saltUnit: String
    var saturatedFat: Double
    var saturatedFatUnit: String
    var sodium: Double
    var sodiumUnit: String
    var sugars: Double
    var sugarsUnit: String
}

struct MicroNutrientsDto: Codable {
    var alcohol: Double
    var betaCarotene: Double
    var calcium: Double
    var cholesterol: Double
    var copper: Double
    var fructose: Double
    var galactose: Double
    var glucose: Double
    var iodine: Double
    var iron: Double
    var lactose: Double
    var magnesium: Double
    var maltose: Double
    var manganese: Double
    var pantothenicAcid: Double
    var phosphorus: Double
    var phylloquinone: Double
    var polyols: Double
    var potassium: Double
    var selenium: Double
    var starch: Double
    var sucrose: Double
    var vitaminA: Double
    var vitaminB12: Double
    var vitaminB: Double
    var vitaminB2: Double
    var vitaminB6: Double
    var vitaminB9: Double
    var vitaminC: Double
    var vitaminD: Double
    var vitaminE: Double
    var vitaminPp: Double
    var water: Double
    var zinc: Double
    var caffeine: Double
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
    
    //    MARK - Fetches the nutrients of today
    func getTodaysNutrients(modelContext: ModelContext) async {
        print("Today's Nutrients")
        await getNutrients(for: Date(), modelContext: modelContext)
    }
    
    //    MARK - Handles the interaction for the view to log a meal based on a barcode
    func sendMealLog(mealType: MealType, eatenInGrams: Int, loggingDate: Date, barcode: String) async {
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

