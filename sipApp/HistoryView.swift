//
//  HistoryView.swift
//  sipApp
//
//  Created by Rif'an M4 on 30/04/25.
//

import SwiftUI


let storage = ProgressStorage()

struct HistoryView: View {
    @State private var selectedDate = Date()
    @State private var progressData: [DailyProgress] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("\(currentMonthSummary.monthName), Target reached \(currentMonthSummary.reachedCount)/\(currentMonthSummary.totalDays) days")
                    .font(.headline)
                    .padding(.top)
                
                // Kalender kustom
                CustomCalendarView(selectedDate: $selectedDate, progressData: progressData)
                
                // Keterangan
//                Text(InfoDate(selectedDate))
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color("BackgroundBlue"))
//                    .cornerRadius(10)
//                    .padding(.horizontal)
                let progress = getProgress(for: selectedDate)

                DailyProgressCard(date: selectedDate, value: progress.amount, total: progress.target)

                
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
        }.onAppear {
            loadData()
        }
    }
    func loadData() {
            storage.seedIfEmpty()
            progressData = storage.load()
    }
    func getProgress(for date: Date) -> (amount: Int, target: Int) {
        if let progress = progressData.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            return (Int(progress.total), Int(progress.target))
        }
        return (0, 2700)
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
            Text("Water Intake on This Day")
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


#Preview {
    HistoryView()
}
