//
//  Entity.swift
//  sipApp
//
//  Created by Keinan Wardhana on 07/04/25.
//

import SwiftUI

// Biodata is for saving data from Biodata Page
//@Observable
class Biodata: ObservableObject {
    var name = "Not Set"
    @Published var weight = 0
    @Published var age = 0
    @Published var gender = ""
    @Published var isFasting = false
}

//@Observable
class Preferences: ObservableObject {
    @Published var interval = 0
    @Published var startActive = Date.now
    @Published var endActive = Date.now
    @Published var unit = "kg/mL"
    @Published var waterIntake = 10
    @Published var isSoundActive = false
    @Published var isRecurring = false
    
    @Published var activeDuration = 1
    @Published var sipCapacity = 0.0
    @Published var sipCapacityGlass = 0.00
}
//
//class BackendData {
//    var Biodata: Biodata
//    var Preferences: Preferences
//    
//    init(Biodata: Biodata, Preferences: Preferences) {
//        self.Biodata = Biodata
//        self.Preferences = Preferences
//    }
//}
