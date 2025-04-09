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
    
    @State var name: String = ""
    @State var weight: Int = 0
    @State var age: Int = 0
    @State var selectedGender: String = "Not Set"
    @State var fasting: Bool = false
    
    @State var showModal = false
    @State var moveToPreferences = false
    
    let genders = ["Not Set", "Male", "Female"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    List{
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
                                    TextField("\(biodata.weight)", value: $weight, format: .number)
                                        .frame(width: 50, height: 10)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.gray)
                                }
                                Text("kg")
                            }
                            HStack{
                                Text("Age")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("\(biodata.age)", value: $age, format: .number)
                                    .frame(width: 200, height: 10)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                Text("yrs")
                            }
                            HStack{
                                Text("Gender")
                                    .foregroundColor(.gray)
                                Spacer()
                                VStack{
                                    Picker("", selection: $selectedGender){
                                        ForEach(genders, id: \.self){
                                            Text($0)
                                        }
                                    }
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                                    .frame(width: 200, height: 10)
                                    
                                }
                            }
                            HStack{
                                Text("Fasting")
                                    .foregroundColor(.gray)
                                Spacer()
                                Toggle("", isOn: $fasting)
                                    .toggleStyle(SwitchToggleStyle(tint: .cyan))
                            }
                        }
                        Section{
                            HStack{
                                Button{
                                    moveToPreferences = true
                                    biodata.name = name
                                    biodata.weight = weight
                                    biodata.age = age
                                    biodata.gender = selectedGender
                                    biodata.isFasting = fasting
                                    
                                    preferences.waterIntake = biodata.weight * 30
                                    
                                    print("\(biodata.name) \(weight) \(age) \(fasting) \(selectedGender)")
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
                                    NavigationLink(
                                        destination: InitialPreferencesView(biodata: biodata, preferences: preferences),
                                        isActive: $moveToPreferences,
                                        label: { EmptyView() }
                                    )
                                    .hidden()
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
                            Rectangle()
                                .fill(Color.red.opacity(0))
                                .frame(width: 20, height: 90)
                        }
                    }
                    
                }
                Text("Biodata")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .fontWeight(.heavy)
                    .padding(.top, -65)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

#Preview {
    InitialBiodataView()
}
