////
////  Widget.swift
////  sipApp
////
////  Created by Rif'an M4 on 19/05/25.
////
//
//import WidgetKit
//import SwiftUI
//
//struct DailyProgressEntry: TimelineEntry {
//    let date: Date
//    let progress: DailyProgress
//}
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> DailyProgressEntry {
//        DailyProgressEntry(date: Date(), progress: DailyProgress(date: Date(), total: 1800, target: 2700, times: []))
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (DailyProgressEntry) -> ()) {
//        let entry = DailyProgressEntry(date: Date(), progress: DailyProgress(date: Date(), total: 1800, target: 2700, times: []))
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyProgressEntry>) -> ()) {
//        // Replace with real loading logic if needed
//        let progress = DailyProgress(date: Date(), total: 1800, target: 2700, times: [])
//        let entry = DailyProgressEntry(date: Date(), progress: progress)
//        let timeline = Timeline(entries: [entry], policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct WaterWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        ZStack {
//            Color("WidgetBackground")
//            VStack(alignment: .leading) {
//                Text("Water Intake")
//                    .font(.headline)
//                Spacer()
//                Text("\(entry.progress.total) / \(entry.progress.target) mL")
//                    .font(.title2)
//                    .bold()
//            }
//            .padding()
//        }
//    }
//}
//
//@main
//struct WaterWidget: Widget {
//    let kind: String = "WaterWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            WaterWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("Daily Water Tracker")
//        .description("Shows your daily hydration progress.")
//        .supportedFamilies([.systemSmall, .systemMedium])
//    }
//}
