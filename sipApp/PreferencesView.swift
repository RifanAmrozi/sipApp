//
//  PreferencesView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct PreferencesView: View {
    @State var interval: Int = 30
    @State var initialActiveHours: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @State var finalActiveHours: Date = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!
    @State var unit: String = ""
    @State var waterIntake: Int = 0
    @State var sound: Bool = false
    @State var recurring: Bool = false
    
    @State var preferences = Preferences()
    
    @State var showModal = false
    
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State private var showDiscardAlert = false
    @State private var hasUnsavedChanges = true
    
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
                            TextField("\(preferences.waterIntake)", value: $waterIntake, format: .number)
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
                            Spacer()
                            Button {
                                showModal = true
                                hasUnsavedChanges = false
                                preferences.interval = interval
                                preferences.unit = unit
                                preferences.waterIntake = waterIntake
                                preferences.isSoundActive = sound
                                preferences.isRecurring = recurring
                                
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
                                    
                                    ModalView()
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
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            if hasUnsavedChanges {
                                showDiscardAlert = true
                            } else {
                                dismiss()
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Preferences")
                            .font(.title)
                            .foregroundColor(Color("WaterBlue"))
                            .fontWeight(.heavy)
                    }
                }
                .alert("Discard unsaved changes?", isPresented: $showDiscardAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Discard", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
        .background(.gray)
    }
}

#Preview {
    PreferencesView()
}
