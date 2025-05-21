//
//  BiodataView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct InitialBiodataView: View {
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    @State var name: String
    @State var weight: Int
    @State var inpWeight: String = ""
    @State var age: Int
    @State var inpAge: String = ""
    @State var selectedGender: String
    @State var fasting: Bool
    @State var showModal = false
    @FocusState private var isWeightFocused: Bool
    @FocusState private var isAgeFocused: Bool
    
    @State var moveToPreferences: Bool = false
    
    
    let genders = ["Not Set", "Male", "Female"]
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section{
                        HStack{
                            Text("Name")
                                .foregroundColor(.gray)
                            Spacer()
                            VStack{
                                TextField("\(biodata.name)", text: $name)
                                    .frame(width: 200, height: 10)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                        }
                        HStack{
                            Text("Weight")
                                .foregroundColor(.gray)
                            Spacer()
                            VStack{
                                TextField("\(biodata.weight)", text: $inpWeight)
                                        .keyboardType(.numberPad)
                                        .frame(width: 60, height: 30)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.gray)
                                        .focused($isWeightFocused)
                                        .onTapGesture {
                                            if inpWeight == "0" {
                                                inpWeight = ""
                                            }
                                        }
                                        .onChange(of: inpWeight) {
                                            // Sanitize input to allow digits only
                                            inpWeight = inpWeight.filter { $0.isNumber }

                                            // Update actual numeric value
                                            weight = Int(inpWeight) ?? 0
                                        }
                            }
                            Text("kg")
                        }
                        HStack{
                            Text("Age")
                                .foregroundColor(.gray)
                            Spacer()
                            TextField("\(biodata.age)", text: $inpAge)
                                .keyboardType(.numberPad)
                                .frame(width: 60, height: 30)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                                .focused($isAgeFocused)
                                .onTapGesture {
                                    if inpAge == "0" {
                                        inpAge = ""
                                    }
                                }
                                .onChange(of: inpAge) {
                                    // Sanitize input to allow digits only
                                    inpAge = inpAge.filter { $0.isNumber }

                                    // Update actual numeric value
                                    age = Int(inpAge) ?? 0
                                }
                            Text("yrs")
                        }
//                        HStack{
//                            Text("Gender")
//                                .foregroundColor(.gray)
//                            Spacer()
//                            VStack{
//                                Picker("", selection: $selectedGender){
//                                    ForEach(genders, id: \.self){
//                                        Text($0)
//                                    }
//                                }
//                                .multilineTextAlignment(.trailing)
//                                .foregroundColor(.gray)
//                                .frame(width: 200, height: 10)
//                                
//                            }
//                        }
//                        HStack{
//                            Text("Fasting")
//                                .foregroundColor(.gray)
//                            Spacer()
//                            Toggle("", isOn: $fasting)
//                                .toggleStyle(SwitchToggleStyle(tint: .cyan))
//                        }
                    }
                    Section{
                        HStack{
                            Button{
                                biodata.name = name
                                biodata.weight = weight
                                biodata.age = age
                                biodata.gender = selectedGender
                                biodata.isFasting = fasting
                                
                                preferences.waterIntake = weight * 30
                                preferences.interval = 30
//                                preferences.sipCapacity = (Double(preferences.interval) / Double(preferences.activeDuration)) * Double(preferences.waterIntake)
//                                
//                                if (preferences.unit == "kg/mL"){
//                                    preferences.sipCapacityGlass = Double(preferences.sipCapacity) / 240
//                                }
                            } label: {
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
                            .background{
                                NavigationLink(destination: InitialPreferencesView(biodata: biodata, preferences: preferences), isActive: $moveToPreferences) {
                                    EmptyView()
                                }
                            }
                        }
                    }
                    .listRowBackground(Color("WaterBlue").opacity(0))
                    .foregroundStyle(Color.white)
                    
                }
                .listSectionSpacing(350)
                .background(Color("BackgroundYellow"))
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Biodata")
                            .font(.title)
                            .foregroundColor(Color("WaterBlue"))
                            .fontWeight(.heavy)
                    }
                }

            }
        }
    }
}

#Preview {
    InitialBiodataView(name: "", weight: 0, age: 0, selectedGender: "Not Set", fasting: false)
}
