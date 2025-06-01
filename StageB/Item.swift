//
//  Item.swift
//  StageB
//
//  Created by Niklas Endter on 01.06.25.
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
