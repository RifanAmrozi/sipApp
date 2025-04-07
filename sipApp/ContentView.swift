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
                        }) {
                            Image(systemName: "gearshape")
                        }
                        Button(action: {
                            // TODO: About button action
                            print("About tapped")
                        }) {
                            Image(systemName: "questionmark.circle")
                        }
                    }
                }
            }
        }
    }
}

struct WaterGlassView: View {
    @State private var waveOffset: CGFloat = 0.0
    @State private var waterLevelOffset: CGFloat = 0 // Starts at 0
    
    var body: some View {
        ZStack {

            VStack {
                Spacer()
                
                ZStack {
                    // Glass Shape
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 150, height: 300)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 2))
                        .shadow(radius: 5)

                    // Water Shape with Animation
                    WaterShape(offset: waveOffset)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color("WaterBlue").opacity(0.5), Color("WaterBlue").opacity(0.8)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 140, height: 250)
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
                    // Increase water level (move up to 80)
                    withAnimation {
                        waterLevelOffset += 10
                        if waterLevelOffset > 100 {
                            waterLevelOffset = 110
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

// Water Wave Shape
struct WaterShape: Shape {
    var offset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight: CGFloat = 10
        
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        
        for x in stride(from: 0, to: rect.width, by: 5) {
            let y = waveHeight * sin((x / rect.width) * .pi * 2 + offset) + rect.height / 2
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    ContentView()
}
