//
//  PreferencesView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct PreferencesView: View {
    @State var interval: Date
    @State var initialActiveHours: Date
    @State var finalActiveHours: Date
    @State var unit: String
    @State var waterIntake: String
    @State var sound: Bool
    @State var recurring: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section {
                        HStack{
                            Text("Interval")
                                .foregroundColor(.gray)
                            Spacer()
                            DatePicker("", selection: $interval, displayedComponents: .hourAndMinute)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                                .labelsHidden()
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
                                Text("kg/ml").tag("kg/ml")
                                Text("lbs/oz").tag("lbs/oz")
                            }
                                .frame(height: 10)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Text("Water Intake")
                                .foregroundColor(.gray)
                            TextField("", text: $waterIntake)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                            Text("ml")
                                .foregroundColor(.gray)
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
                    }
                    
                }
                .listSectionSpacing(50)
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
    PreferencesView(interval: Date.now, initialActiveHours: Date.now, finalActiveHours: Date.now, unit: "", waterIntake: "", sound: false, recurring: false)
}
