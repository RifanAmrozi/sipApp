//
//  ContentView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundYellow")
                    .ignoresSafeArea(.all)
                WaterGlassView()
                
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



#Preview {
    ContentView()
}
