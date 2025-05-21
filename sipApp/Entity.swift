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
    @Published var name = "Not Set"
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
    @Published var waterIntake = 0
    @Published var isSoundActive = false
    @Published var isRecurring = false
    
    @Published var activeDuration = 0
    @Published var sipCapacity = 0.0
    @Published var sipCapacityGlass = 0.0
}

struct DailyProgress: Codable, Hashable {
    let date: Date
    var total: Int       // e.g., 2500
    var target: Int      // e.g., 2700
    var times: [String]  // e.g., ["08:26", "08:56"]
    
    var percentage: CGFloat {
        guard target > 0 else { return 0 }
        return CGFloat(total) / CGFloat(target)
    }
}

struct SemiCircleProgressView: View {
    var progress: CGFloat // 0.0 to 1.0
    var total: Int
    var value: Int

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .stroke(Color.gray.opacity(0.4), lineWidth: 15)
                .rotationEffect(.degrees(180))
            
            Circle()
                .trim(from: 0.0, to: progress * 0.5)
                .stroke(Color("WaterBlue"), lineWidth: 15)
                .rotationEffect(.degrees(180))
            
            VStack(spacing: 4) {
                Text("\(value)")
                    .font(.system(size: 20, weight: .bold))
                    .underline()
                Text("\(total)")
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .frame(width: 180, height: 90)
    }
}

struct DailyProgressSummaryView: View {
    var date: Date
    var value: Int
    var total: Int

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("At \(formattedDate),")
            Text("you reach \(value) mL")
            Text("from \(total) mL your")
            Text("daily goals")
        }
        .font(.system(size: 14, weight: .semibold))
        .foregroundColor(Color("WaterBlue"))
    }
}

struct DailyProgressCard: View {
    var date: Date
    var value: Int
    var total: Int

    var body: some View {
        HStack {
            SemiCircleProgressView(
                progress: CGFloat(value) / CGFloat(total),
                total: total,
                value: value
            )

            DailyProgressSummaryView(
                date: date,
                value: value,
                total: total
            )
            .padding(.trailing)
        }
        .padding()
        .background(Color.blue.opacity(0.15))
        .cornerRadius(24)
        .padding()
    }
}
