//
//  ContentView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI
import Foundation
import Combine


struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundYellow")
                    .ignoresSafeArea(.all)
                WaterGlassView()
                TimerView()
                GoalView()
            }
            .toolbarBackground(Color("BackgroundYellow"), for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack{
                        Button(action: {
                            // TODO: Action for settings button
                            print("Settings tapped: Show Biodata and Preference")
                            sendNotification()
                        }) {
                            Image(systemName: "gearshape")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .padding(.top)
                        Button(action: {
                            // TODO: About button action
                            print("Start Notifying Every 60s")
                            requestNotificationPermission()
                            scheduleNotification()
                        }) {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }
        }
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("✅ Permission granted")
                } else {
                    print("❌ Permission denied")
                }
            }
        }
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Sip!"
        content.body = "This is your drink reminder 🕙"
        content.sound = UNNotificationSound.default

        for seconds in stride(from: 60, through: 300, by: 60) { // TODO: for repeating 5 times
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("❌ Notification error: \(error)")
                } else {
                    print("📬 Notification scheduled")
                }
            }
        }
    }
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hi 👋"
        content.body = "This is a friendly notification!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification Error: \(error.localizedDescription)")
            } else {
                print("📬 Notification scheduled")
            }
        }
    }
}
struct Trapezium: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let inset: CGFloat = rect.width * 0.15 // adjust for "slant"
        path.move(to: CGPoint(x: -inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width + inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct WaterGlassView: View {
    @State private var waveOffset: CGFloat = 0.0
    @State private var waterLevelOffset: CGFloat = 30 // default starts at 30 to add space top
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var viewModel: GoalViewModel
    
    var body: some View {
        ZStack {

            VStack {
                Spacer()
                
                ZStack {
                    // Glass Shape
                    Trapezium()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 150, height: 300)
                        .overlay(
                            Trapezium()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                        )
                        .shadow(radius: 5)


                    // Water Shape with Animation
                    WaterShape(offset: waveOffset)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color("WaterBlue").opacity(0.5), Color("WaterBlue").opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 140, height: 280)
                        .offset(y: waterLevelOffset)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("WaterBlue"))
                        .frame(width:100, height: 65)
                    Text("Sip!")
                        .bold(true)
                        .foregroundStyle(.white)
                }
                .onTapGesture {
                    print("Sip! Pressed")
                    withAnimation {
                        waterLevelOffset += 10 // TODO: replace with unit per drink water
                        if waterLevelOffset > 270 { //TODO: replace with max water
                            waterLevelOffset = 280
                        }
                    }
                    timerManager.startCountdown()
                    viewModel.addProgress()
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset = .pi * 2
            }
        }
    }
}

struct WaterShape: Shape {
    var offset: CGFloat
    var insetRatio: CGFloat = 0.15 // matches Trapezium inset

    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight: CGFloat = 10
        let inset = rect.width * insetRatio
        let topWidth = rect.width + inset * 2

        // 👇 Start wave from top
        path.move(to: CGPoint(x: -inset, y: 0))

        for x in stride(from: -inset, through: rect.width + inset, by: 5) {
            let relativeX = x + inset
            let y = waveHeight * sin((relativeX / topWidth) * .pi * 2 + offset)
            path.addLine(to: CGPoint(x: x, y: y))
        }

        // 👇 Close the wave to bottom of the rect
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}

struct TimerView: View {
    @EnvironmentObject var timerManager: TimerManager  // Shared manager

       var body: some View {
           VStack(spacing: 20) {
               Text(formatTime(timerManager.timeRemaining))  // Reacts to updates
                   .font(.largeTitle)
                   .bold()
                   .foregroundColor(Color("DeepWaterBlue"))
               Spacer()
           }
       }

       func formatTime(_ seconds: Int) -> String {
           let formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.hour, .minute, .second]
           formatter.zeroFormattingBehavior = [.pad]
           return formatter.string(from: TimeInterval(seconds)) ?? "00:00:00"
       }
}

struct GoalView: View {
    @EnvironmentObject var viewModel: GoalViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(viewModel.currentProgress) / \(viewModel.goalTarget)")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color("DeepWaterBlue"))
            }
        .padding()
    }
}

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 10800
    private var timer: Timer?

    func startCountdown() {
        timer?.invalidate()
        timeRemaining = 10800

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }

    func stopCountdown() {
        timer?.invalidate()
    }
}

class GoalViewModel: ObservableObject {
    @Published var intervalProgress: Int = 300
    @Published var currentProgress: Int = 0
    @Published var goalTarget: Int = 2700

    func addProgress() {
        if currentProgress < goalTarget {
            currentProgress += intervalProgress
        }
    }

    func resetProgress() {
        currentProgress = 0
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerManager())
        .environmentObject(GoalViewModel())
}
