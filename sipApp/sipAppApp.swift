//
//  sipAppApp.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

@main
struct sipAppApp: App {
    @StateObject var timerManager = TimerManager()
    @StateObject private var viewModel = GoalViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environmentObject(timerManager)
//                .environmentObject(viewModel)
            InitialBiodataView(name: "", weight: 0, age: 0, selectedGender: "Not Set", fasting: false)
        }
    }
}
