//
//  Entity.swift
//  sipApp
//
//  Created by Keinan Wardhana on 07/04/25.
//

import SwiftUI

// Biodata is for saving data from Biodata Page
@Observable
class Biodata {
    var name = "Not Set"
    var weight = 0
    var age = 0
    var gender = "Not Set"
    var isFasting = false
}

@Observable
class Preferences {
    var interval = 0
    var startActive = "2025-04-08 08:31:00 +0000"
    var endActive = "2025-04-08 10:31:00 +0000"
    var unit = "kg/mL"
    var waterIntake = 0
    var isSoundActive = false
    var isRecurring = false
}

class BackendDate {
    var Biodata: Biodata
    var Preferences: Preferences
    
    init(Biodata: Biodata, Preferences: Preferences) {
        self.Biodata = Biodata
        self.Preferences = Preferences
    }
}
