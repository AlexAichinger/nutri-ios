//
//  MealType.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation

enum MealType: String, CaseIterable, Identifiable, CustomStringConvertible {
    case BREAKFAST
    case LUNCH
    case DINNER
    case SNACK
    
    var id: Self { self }
    
    var description: String {
        
        switch self {
        case .BREAKFAST:
            return "Brekkie"
        case .LUNCH:
            return "Lunch"
        case .DINNER:
            return "Din Din"
        case .SNACK:
            return "Snackity Snack"
        }
    }
}
