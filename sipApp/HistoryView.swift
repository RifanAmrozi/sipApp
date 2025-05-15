//
//  HistoryView.swift
//  sipApp
//
//  Created by Rif'an M4 on 30/04/25.
//

import SwiftUI

struct DailyProgress {
    let date: Date
    let total: Int       // e.g., 2500
    let target: Int      // e.g., 2700
    let times: [String]  // e.g., ["08:26", "08:56"]
    
    var percentage: CGFloat {
        guard target > 0 else { return 0 }
        return CGFloat(total) / CGFloat(target)
    }
}


struct HistoryView: View {
    @State private var selectedDate = Date()

    let progressData: [DailyProgress] = generateMockProgress()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("\(currentMonthSummary.monthName), Target reached \(currentMonthSummary.reachedCount)/\(currentMonthSummary.totalDays) days")
                    .font(.headline)
                    .padding(.top)
                
                // Kalender kustom
                CustomCalendarView(selectedDate: $selectedDate, progressData: progressData)
                
                // Keterangan
                Text(InfoDate(selectedDate))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("BackgroundBlue"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Timeline Diagram
                TimelineView(times: timesForSelectedDate(selectedDate))
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundYellow"))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("History")
                        .font(.title)
                        .foregroundColor(Color("WaterBlue"))
                        .fontWeight(.heavy)
                }
            }
        }
    }

    func InfoDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long

        // Target harian (misal 2700 ml)
        let dailyTarget: CGFloat = 2700

        if let progress = progressData.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            let amountDrank = Int(progress.percentage * dailyTarget)
            return "\(formatter.string(from: date)): Kamu minum \(amountDrank) dari \(Int(dailyTarget)) ml targetmu 💧"
        } else {
            return "Belum ada data di \(formatter.string(from: date))"
        }
    }
    func timesForSelectedDate(_ date: Date) -> [String] {
            progressData.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })?.times ?? []
    }
    var currentMonthSummary: (monthName: String, reachedCount: Int, totalDays: Int) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return ("Unknown", 0, 0)
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"

        let monthName = formatter.string(from: startOfMonth)
        let totalDays = range.count

        let reachedCount = progressData.filter {
            calendar.isDate($0.date, equalTo: startOfMonth, toGranularity: .month)
            && $0.total >= $0.target
        }.count

        return (monthName.capitalized, reachedCount, totalDays)
    }

}

struct CustomCalendarView: View {
    @Binding var selectedDate: Date
    let progressData: [DailyProgress]

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var daysInMonth: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.year, .month], from: today)
        let startOfMonth = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }


    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(daysInMonth, id: \.self) { day in
                let percent = progressForDate(day)
                let isSelected = Calendar.current.isDate(day, inSameDayAs: selectedDate)

                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("BackgroundBlue"))

                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("WaterBlue"))
                        .frame(height: 40 * percent)

                    Text("\(Calendar.current.component(.day, from: day))")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("DarkestBlue"))
                        .padding(4)
                }
                .frame(height: 40)
                .background(isSelected ? Color.white : Color("BlueBackground"))
                .cornerRadius(8)
                .onTapGesture {
                    selectedDate = day
                }
            }
        }
        .padding()
    }

    func progressForDate(_ date: Date) -> CGFloat {
        progressData.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })?.percentage ?? 0
    }
}
struct TimelineView: View {
    let times: [String] // e.g., ["08:30", "09:00", "10:15", ...]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Timeline")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            ScrollView(.vertical, showsIndicators: true) {
                ZStack(alignment: .top) {
                    // Vertical line
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: 4)
                        .padding(.top, 10)

                    // Dots + labels
                    VStack(spacing: 40) {
                        ForEach(Array(times.enumerated()), id: \.offset) { index, time in
                            HStack(alignment: .center, spacing: 130) {
                                Spacer(minLength: 0)
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color("WaterBlue"))

                                    // Time label
                                    Text(time)
                                        .font(.caption)
                                        .frame(width: 50, alignment: .center)

                                }
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 40)
                .padding(.vertical, 50)
            }
        }
    }
}




func generateMockProgress() -> [DailyProgress] {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    return [
        DailyProgress(date: formatter.date(from: "2025-05-19")!, total: 2700, target: 2700, times: ["08:26", "08:56"]),
        DailyProgress(date: formatter.date(from: "2025-05-18")!, total: 1800, target: 2700, times: ["09:10"]),
        DailyProgress(date: formatter.date(from: "2025-05-17")!, total: 1200, target: 2700, times: ["07:45", "10:20", "13:00"]),
        DailyProgress(date: formatter.date(from: "2025-05-16")!, total: 2700, target: 2700, times: ["08:00"]),
        DailyProgress(date: formatter.date(from: "2025-05-15")!, total: 1800, target: 2700, times: ["08:26"
                                                                                                    , "08:56"
                                                                                                    ,"09:26"
                                                                                                    ,"09:56","10:26", "10:56"
                                                                                                   ]),
        DailyProgress(date: formatter.date(from: "2025-05-14")!, total: 1200, target: 2700, times: ["11:30", "15:15"]),
        DailyProgress(date: formatter.date(from: "2025-05-13")!, total: 2700, target: 2700, times: ["08:00"]),
        DailyProgress(date: formatter.date(from: "2025-05-12")!, total: 1800, target: 2700, times: []),
        DailyProgress(date: formatter.date(from: "2025-05-11")!, total: 2700, target: 2700, times: ["11:30", "15:15"])
    ]
}


#Preview {
    HistoryView()
}
