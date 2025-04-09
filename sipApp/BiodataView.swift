//
//  BiodataView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct BiodataView: View {
    @State var name: String = ""
    @State var weight: Int = 0
    @State var age: Int = 0
    @State var selectedGender: String = "Not Set"
    @State var fasting: Bool = false
    
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    @State var showModal = false
    @State var moveToHome = false
    
    @Environment(\.dismiss) var dismiss
    @State var showDiscardAlert = false
    @State var hasUnsavedChanges = true
    let genders = ["Not Set", "Male", "Female"]
    
    @StateObject var timerManager = TimerManager()
    @StateObject private var viewModel = GoalViewModel()
    
    var body: some View {
        NavigationStack(){
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
                                    TextField("", value: $weight, format: .number)
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
                                TextField("", value: $age, format: .number)
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
                                    
                                    biodata.name = name
                                    biodata.weight = weight
                                    biodata.age = age
                                    biodata.gender = selectedGender
                                    biodata.isFasting = fasting
                                    
                                    preferences.waterIntake = biodata.weight * 30
                                    
                                    print("\(biodata.name) \(weight) \(age) \(fasting) \(selectedGender)")
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
                        .listRowBackground(Color("WaterBlue").opacity(0))
                        .foregroundStyle(Color.white)
                        
                    }
                    .listSectionSpacing(350)
                    .background(Color("BackgroundYellow"))
                    .scrollContentBackground(.hidden)
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
                            Rectangle()
                                .fill(Color.red.opacity(0))
                                .frame(width: 20, height: 90)
                        }
                    }
                    .alert("Discard unsaved changes?", isPresented: $showDiscardAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Discard", role: .destructive) {
                            dismiss()
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
        .onAppear{
            age = biodata.age
            weight = biodata.weight
            selectedGender = biodata.gender
            fasting = biodata.isFasting
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    BiodataView()
}
