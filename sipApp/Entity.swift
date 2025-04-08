//
//  Entity.swift
//  sipApp
//
//  Created by Keinan Wardhana on 07/04/25.
//

import Foundation

// Biodata is for saving data from Biodata Page
class Biodata {
    var name: String
    var weight: Int
    var age: Int
    var gender: String
    var isFasting: Bool
    
    init(name: String, weight: Int, age: Int, gender: String, isFasting: Bool) {
        self.name = name
        self.weight = weight
        self.age = age
        self.gender = gender
        self.isFasting = isFasting
    }
}

class Preferences {
    var interval: Int
    var startActive: String
    var endActive: String
    var unit: String
    var intakeGoal: Int
    var isSoundActive:  Bool
    var isRecurring: Bool
    
    init(interval: Int, startActive: String, endActive: String, unit: String, intakeGoal: Int, isSoundActive: Bool, isRecurring: Bool) {
        self.interval = interval
        self.startActive = startActive
        self.endActive = endActive
        self.unit = unit
        self.intakeGoal = intakeGoal
        self.isSoundActive = isSoundActive
        self.isRecurring = isRecurring
    }
}

class BackendData {
    var Biodata: Biodata
    var Preferences: Preferences
    
    init(Biodata: Biodata, Preferences: Preferences) {
        self.Biodata = Biodata
        self.Preferences = Preferences
    }
}
