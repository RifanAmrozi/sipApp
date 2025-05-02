//
//  HistoryView.swift
//  sipApp
//
//  Created by Rif'an M4 on 30/04/25.
//

import SwiftUI

struct DailyProgress {
    let date: Date
    let percentage: CGFloat // 0.0 to 1.0
}

struct HistoryView: View {
    @State private var selectedDate = Date()

    let progressData: [DailyProgress] = generateMockProgress()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Kalender kustom
                CustomCalendarView(selectedDate: $selectedDate, progressData: progressData)
                
                // Keterangan
                Text(InfoDate(selectedDate))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundYellow"))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("History")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .fontWeight(.heavy)
                        .padding(.top, 50)
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
}

struct CustomCalendarView: View {
    @Binding var selectedDate: Date
    let progressData: [DailyProgress]

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var daysInMonth: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let range = calendar.range(of: .day, in: .month, for: today)!
        return range.compactMap {
            calendar.date(bySetting: .day, value: $0, of: today)
        }
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(daysInMonth, id: \.self) { day in
                let percent = progressForDate(day)
                let isSelected = Calendar.current.isDate(day, inSameDayAs: selectedDate)

                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.1))

                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blue)
                        .frame(height: 40 * percent)

                    Text("\(Calendar.current.component(.day, from: day))")
                        .font(.caption)
                        .foregroundColor(isSelected ? .white : .black)
                        .padding(4)
                }
                .frame(height: 40)
                .background(isSelected ? Color.blue : Color.clear)
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

func generateMockProgress() -> [DailyProgress] {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    let data: [DailyProgress] = [
        DailyProgress(date: formatter.date(from: "2025-05-29")!, percentage: 2500 / 2700), // ~92.6%
        DailyProgress(date: formatter.date(from: "2025-05-28")!, percentage: 1800 / 2700), // ~66.7%
        DailyProgress(date: formatter.date(from: "2025-05-27")!, percentage: 1200 / 2700), // ~44.4%
        DailyProgress(date: formatter.date(from: "2025-05-26")!, percentage: 2500 / 2700), // ~92.6%
        DailyProgress(date: formatter.date(from: "2025-05-25")!, percentage: 1800 / 2700), // ~66.7%
        DailyProgress(date: formatter.date(from: "2025-05-24")!, percentage: 1200 / 2700)  // ~44.4%
    ]

    return data
}

#Preview {
    HistoryView()
}
