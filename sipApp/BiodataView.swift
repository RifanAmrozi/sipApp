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
    @State var inpWeight: String = ""
    @State var age: Int
    @State var inpAge: String = ""
    @State var selectedGender: String
    @State var fasting: Bool
    @State var showModal = false
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    @FocusState private var isWeightFocused: Bool
    @FocusState private var isAgeFocused: Bool
    
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State private var showDiscardAlert = false
    @State private var hasUnsavedChanges = true
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
                                TextField("0", text: $inpWeight)
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
                            TextField("0", text: $inpAge)
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
                        HStack{
                            Text("Gender")
                                .foregroundColor(.gray)
                            Spacer()
                            VStack{
                                Picker("", selection: $biodata.gender){
                                    ForEach(genders, id: \.self){
                                        Text($0)
                                    }
                                }
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                                .frame(width: 200, height: 10)
                                
                            }
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
    }
}

#Preview {
    BiodataView(name: "", weight: 0, age: 0, selectedGender: "", fasting: false)
}
