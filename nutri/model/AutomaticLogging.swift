//
//  AutomaticLogging.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation

struct AutomaticLogging: Codable {
    let user: String
    let mealType: String
    let eatenInGrams: Int
    let loggingDate: String
    let barcode: String
}
