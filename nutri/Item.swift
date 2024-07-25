//
//  Item.swift
//  nutri
//
//  Created by Alex Aichinger on 25/7/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
