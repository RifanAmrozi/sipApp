//
//  PreferencesView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI
import Foundation

struct InitialPreferencesView: View {
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    @StateObject var timerManager = TimerManager()
    @StateObject private var viewModel = GoalViewModel()
    
    @State var interval: Int = 0
    @State var initialActiveHours: Date = Date.now
    @State var finalActiveHours: Date = Date.now
    @State var unit: String = ""
    @State var waterIntake: Int = 0
    @State var sound: Bool = false
    @State var recurring: Bool = false
    @State var minutes: Int = 0
    
    @State var showModal = false
    @State var moveToHome = false
    
    let units = ["kg/mL", "lbs/oz"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    List{
                        Section {
                            HStack{
                                Text("Interval")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("", value: $interval, format: .number)
                                    .frame(width: 200, height: 10)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                Text("mins")
                            }
                            HStack{
                                Text("Active Hours")
                                    .foregroundColor(.gray)
                                Spacer(minLength: 50)
                                DatePicker("", selection: $initialActiveHours, displayedComponents: .hourAndMinute)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .labelsHidden()
                                Text("to")
                                    .foregroundColor(.gray)
                                DatePicker("", selection: $finalActiveHours, displayedComponents: .hourAndMinute)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .labelsHidden()
                            }
                            HStack{
                                Text("Unit")
                                    .foregroundColor(.gray)
                                Picker("", selection: $unit) {
                                    ForEach(units, id: \.self){
                                        Text($0)
                                    }
                                }
                                .frame(height: 10)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            }
                            HStack{
                                Text("Water Intake")
                                    .foregroundColor(.gray)
                                TextField("", value: $waterIntake, format: .number)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                Text("mL")
                            }
                        }
                        footer: {
                            Text("By default, your water intake goal will be calculated for you according to your biodata. Please only change the goal if necessary.")
                            
                        }
                        
                        Section {
                            HStack{
                                Text("Sound")
                                    .foregroundColor(.gray)
                                Toggle("", isOn: $sound)
                                    .toggleStyle(SwitchToggleStyle(tint: .cyan))
                            }
                            HStack{
                                Text("Recurring Notifications")
                                    .foregroundColor(.gray)
                                    .frame(width: 200, alignment: .leading)
                                Spacer()
                                Toggle("", isOn: $recurring)
                                    .toggleStyle(SwitchToggleStyle(tint: .cyan))
                            }
                        } header: {
                            Text("Reminders")
                                .headerProminence(.increased)
                                .frame(width: 400)
                        } footer: {
                            Text("When you turn on recurring notifications, you will get another reminder if you don't drink after the required interval.")
                            
                        }
                        
                        Section{
                            HStack{
                                Spacer()
                                Button {
                                    showModal = true
                                    
                                    preferences.interval = interval
                                    preferences.unit = unit
                                    preferences.waterIntake = waterIntake
                                    preferences.isSoundActive = sound
                                    preferences.isRecurring = recurring
                                    preferences.startActive = initialActiveHours
                                    preferences.endActive = finalActiveHours
                                    
                                    timerManager.timeRemaining = (preferences.interval * 60)
                                    
                                    let calendar = Calendar.current
                                    let activeMinutes = calendar.dateComponents([.minute], from: initialActiveHours, to: finalActiveHours).minute ?? 0
                                    
                                    preferences.activeDuration = activeMinutes
                                    
                                    
                                    preferences.sipCapacity = (Double(preferences.interval) / Double(preferences.activeDuration)) * Double(preferences.waterIntake)
                                    
                                    if (preferences.unit == "kg/mL"){
                                        preferences.sipCapacityGlass = preferences.sipCapacity / 240
                                    }
                                    
                                    print("\(biodata.name) \(interval) \(initialActiveHours) \(preferences.activeDuration) \(finalActiveHours) \(unit) \(waterIntake) \(sound) \(preferences.sipCapacityGlass)")
                                } label: {
                                    Text("Save")
                                        .fontWeight(.bold)
                                        .font(.callout)
                                        .frame(width: 100, height: 45, alignment: .center)
                                        .background(Color("WaterBlue"))
                                        .cornerRadius(8)
                                }
                                .sheet(isPresented: $showModal, onDismiss: {
                                    moveToHome = true
                                }) {
                                    NavigationStack{
                                        ZStack{
                                            Color("WaterBlue")
                                                .ignoresSafeArea()
                                            VStack {
                                                
                                                ModalView(biodata: biodata, preferences: preferences)
                                                    .frame(height: 600)
                                                
                                                Button {
                                                    showModal = false
                                                } label: {
                                                    Text("👍  Sip!")
                                                }
                                                //                                            }
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                                .frame(width: 100, height: 20)
                                                .padding()
                                                .background(Color.white)
                                                .foregroundStyle(Color("WaterBlue"))
                                                .cornerRadius(15)
                                            }
                                        }
                                    }
                                }
                                .background{
                                    NavigationLink(
                                        destination: ContentView(biodata: biodata, preferences: preferences).environmentObject(timerManager)
                                            .environmentObject(viewModel),
                                        isActive: $moveToHome,
                                        label: { EmptyView() }
                                    )
                                    .hidden()
                                }
                                Spacer()
                            }
                        }
                        .listSectionSpacing(100)
                        .listRowBackground(Color("WaterBlue").opacity(0))
                        .foregroundStyle(Color.white)
                        
                    }
                    .listSectionSpacing(50)
                    .background(Color("BackgroundYellow"))
                    .scrollContentBackground(.hidden)
                    .safeAreaPadding(.vertical, 5)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Rectangle()
                                .fill(Color.red.opacity(0))
                                .frame(width: 20, height: 90)
                        }
                    }
                    
                }
                Text("Preferences")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .fontWeight(.heavy)
                    .padding(.top, -65)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .onAppear{
            interval = preferences.interval
            waterIntake = preferences.waterIntake
            unit = preferences.unit
            sound = preferences.isSoundActive
            recurring = preferences.isRecurring
        }
        .background(.gray)
    }
}

#Preview {
    InitialPreferencesView()
}
