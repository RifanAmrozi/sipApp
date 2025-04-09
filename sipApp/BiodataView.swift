//
//  BiodataView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct BiodataView: View {
    @State var name: String
    @State var weight: Int
    @State var age: Int
    @State var selectedGender: String
    @State var fasting: Bool
    @State var showModal = false
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State private var showDiscardAlert = false
    @State private var hasUnsavedChanges = true
    let genders = ["Not Set", "Male", "Female"]
    
    var body: some View {
        NavigationStack(){
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
                            Spacer()
                            Button {
                                showModal = true
                                hasUnsavedChanges = false
                                biodata.name = name
                                biodata.weight = weight
                                biodata.age = age
                                biodata.gender = selectedGender
                                biodata.isFasting = fasting
                                
                                preferences.waterIntake = biodata.weight * 30
                                preferences.sipCapacity = (Double(preferences.interval) / Double(preferences.activeDuration)) * Double(preferences.waterIntake)
                                
                                if (preferences.unit == "kg/mL"){
                                    preferences.sipCapacityGlass = Double(preferences.sipCapacity) / 240
                                }
                                
                                print("\(name) \(weight) \(age) \(fasting) \(selectedGender)")
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
                    .listRowBackground(Color("WaterBlue").opacity(0))
                    .foregroundStyle(Color.white)
                    
                }
                .listSectionSpacing(350)
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
                        Text("Biodata")
                            .font(.title)
                            .foregroundColor(Color.black)
                            .fontWeight(.heavy)
                            .padding(.top, 50)
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
    }
}

#Preview {
    BiodataView(name: "", weight: 0, age: 0, selectedGender: "", fasting: false)
}
