//
//  PreferencesView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct InitialPreferencesView: View {
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    @State var interval: Int = 30
    @State var initialActiveHours: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @State var finalActiveHours: Date = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!
    @State var unit: String = ""
    @State var waterIntake: Int = 0
    @State var sound: Bool = false
    @State var recurring: Bool = false
    @State var activeDuration: Int = 30
    
    @State var showModal = false
    
    let units = ["kg/mL", "lbs/oz"]
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section {
                        HStack{
                            Text("Interval")
                                .foregroundColor(.gray)
                            Spacer()
                            TextField("\(preferences.interval)", value: $interval, format: .number)
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
                            Picker("", selection: $preferences.unit) {
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
                            TextField("\(biodata.weight * 30)", value: $waterIntake, format: .number)
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
                            Toggle("", isOn: $preferences.isSoundActive)
                                .toggleStyle(SwitchToggleStyle(tint: .cyan))
                        }
                        HStack{
                            Text("Recurring Notifications")
                                .foregroundColor(.gray)
                                .frame(width: 200, alignment: .leading)
                            Spacer()
                            Toggle("", isOn: $preferences.isRecurring)
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
                            NavigationLink(destination: ContentView()
                                .environmentObject(TimerManager())
                                .environmentObject(GoalViewModel())
                                .navigationBarBackButtonHidden(true)
                            ) {
                                Spacer()
                                Text("Next")
                                    .fontWeight(.bold)
                                    .font(.callout)
                                    .frame(width: 100, height: 45, alignment: .center)
                                    .background(Color("WaterBlue"))
                                    .cornerRadius(8)
                                    .frame(width: 500)
                                Spacer()
                            }
                            Spacer()
                            Button {
                                showModal = true
//                                if(interval==0){
//                                    interval=1
//                                }
                                preferences.interval = interval
                                preferences.unit = unit
                                preferences.waterIntake = waterIntake
                                preferences.isSoundActive = sound
                                preferences.isRecurring = recurring
//                                let activeDuration = finalActiveHours-initialActiveHours
//                                if(activeDuration==0){
//                                    activeDuration=1
//                                }
                                preferences.activeDuration = activeDuration
//                                preferences.sipCapacity = Double(preferences.waterIntake)/( Double(preferences.activeDuration)/Double(preferences.interval))
////
//                                if (preferences.unit == "kg/mL"){
//                                    preferences.sipCapacityGlass = Double(preferences.sipCapacity) / 240
//                                }
                                
                                print("\(interval) \(initialActiveHours) \(preferences.activeDuration) \(finalActiveHours) \(unit) \(waterIntake) \(sound) \(recurring)")
                            } label: {
                                Text("Save")
                                    .fontWeight(.bold)
                                    .font(.callout)
                                    .frame(width: 100, height: 45, alignment: .center)
                                    .background(Color("WaterBlue"))
                                    .cornerRadius(8)
                            }
                            .sheet(isPresented: $showModal) {
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
                        Text("Preferences")
                            .font(.title)
                            .foregroundColor(Color("WaterBlue"))
                            .fontWeight(.heavy)
                    }
                }
                
            }
        }
        .onAppear{
            interval = preferences.interval
            waterIntake = preferences.waterIntake
            recurring = preferences.isRecurring
            sound = preferences.isSoundActive
            unit = preferences.unit
        }
        .background(.gray)
    }
}

#Preview {
    InitialPreferencesView()
}

