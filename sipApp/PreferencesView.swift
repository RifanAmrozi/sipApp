//
//  PreferencesView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct PreferencesView: View {
    @State var interval: String
    @State var initialActiveHours: Date
    @State var finalActiveHours: Date
    @State var unit: String
    @State var waterIntake: String
    @State var sound: Bool
    @State var recurring: Bool
    
    @State var preferences: Preferences
    
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
                            TextField("\(preferences.interval)", text: $interval)
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
                            TextField("\(preferences.waterIntake)", text: $waterIntake)
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
                    }
                    
                    Section{
                        HStack{
                            Spacer()
                            Button {
                                showModal = true
                                print("\(interval) \(initialActiveHours) \(finalActiveHours) \(unit) \(waterIntake) \(sound) \(recurring)")
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
                                    VStack{
                                        Text("Your daily water goal is")
                                            .bold()
                                            .foregroundStyle(Color.white)
                                        Text("2600 mL") //Switch with Volume var
                                            .fontWeight(.heavy)
                                            .padding(.vertical)
                                            .font(.system(size: 44))
                                            .foregroundColor(Color.white)
                                    }
                                    HStack{
                                        Spacer()
                                        VStack{
                                            Text("For every")
                                                .bold()
                                            VStack{
                                                Text("⏰")
                                                    .font(.system(size: 44))
                                                    .padding(.bottom, 2)
                                                Text("30 mins") //Switch with Interval var
                                            }
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .frame(width: 140, height: 140)
                                            .foregroundStyle(Color.black)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .multilineTextAlignment(.center)
                                        }
                                        Spacer()
                                        Text("")
                                            .frame(width: 1, height: 200)
                                            .background(Color.white)
                                        Spacer()
                                        VStack{
                                            Text("you have to drink")
                                                .bold()
                                            VStack{
                                                Text("💧")
                                                    .font(.system(size: 44))
                                                    .padding(.bottom, 2)
                                                Text("160 mL") //Switch with Interval var
                                            }
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .frame(width: 140, height: 140)
                                            .foregroundStyle(Color.black)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .multilineTextAlignment(.center)
                                        }
                                        Spacer()
                                    }
                                    VStack{
                                        Text("That's equivalent to")
                                            .fontWeight(.bold)
                                            .padding(.top, 30)
                                            .foregroundStyle(Color.white)
                                        HStack{
                                            Image("glassOfWater")
                                            Text(" x 1.5")
                                                .fontWeight(.heavy)
                                                .padding(.vertical)
                                                .font(.system(size: 44))
                                                .foregroundColor(Color.white)
                                        }
                                        
                                    }
                                    
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
                                    .padding(.top, 50)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .listSectionSpacing(250)
                    .listRowBackground(Color("WaterBlue").opacity(0))
                    .foregroundStyle(Color.white)
                    
                }
                .listSectionSpacing(50)
                .background(Color("BackgroundYellow"))
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Preferences")
                            .font(.title)
                            .foregroundColor(Color.cyan)
                            .fontWeight(.heavy)
                            .padding(.top, 50)
                    }
                }
                
            }
        }
        .background(.gray)
    }
}

#Preview {
    PreferencesView(interval: "", initialActiveHours: Date.now, finalActiveHours: Date.now, unit: "", waterIntake: "", sound: false, recurring: false, preferences: Preferences())
}
