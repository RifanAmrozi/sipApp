//
//  ProgressStorage.swift
//  sipApp
//
//  Created by Rif'an M4 on 15/05/25.
//

import Foundation

class ProgressStorage {
    private let key = "daily_progress_data"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func save(_ progress: [DailyProgress]) {
        if let data = try? encoder.encode(progress) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [DailyProgress] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? decoder.decode([DailyProgress].self, from: data) else {
            return []
        }
        return decoded
    }

    func seedIfEmpty() {
        if load().isEmpty {
            save(generateMockProgress()) 
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
        DailyProgress(date: formatter.date(from: "2025-05-16")!, total: 2700, target: 2700, times: ["08:26","08:56","09:26","09:56","10:26", "10:56"]),
        DailyProgress(date: formatter.date(from: "2025-05-15")!, total: 1800, target: 2700, times: ["08:26","08:56","09:26","09:56","10:26", "10:56"]),
        DailyProgress(date: formatter.date(from: "2025-05-14")!, total: 1200, target: 2700, times: ["11:30", "15:15"]),
        DailyProgress(date: formatter.date(from: "2025-05-13")!, total: 2700, target: 2700, times: ["08:00"]),
        DailyProgress(date: formatter.date(from: "2025-05-12")!, total: 1800, target: 2700, times: []),
        DailyProgress(date: formatter.date(from: "2025-05-11")!, total: 2700, target: 2700, times: ["11:30", "15:15"])
    ]
}
