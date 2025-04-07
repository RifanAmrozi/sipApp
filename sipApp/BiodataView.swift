//
//  BiodataView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct BiodataView: View {
    @State var name: String
    @State var weight: String
    @State var age: String
    @State var selectedGender: String
    @State var fasting: Bool
    
    @State var showModal = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    Section{
                        HStack{
                            Text("Name")
                                .foregroundColor(.gray)
                            Spacer()
                            VStack{
                                TextField("Not Set", text: $name)
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
                                TextField("", text: $weight)
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
                            VStack{
                                TextField("", text: $age)
                                    .frame(width: 200, height: 10)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                            Text("yrs")
                        }
                        HStack{
                            Text("Gender")
                                .foregroundColor(.gray)
                            Spacer()
                            VStack{
                                Picker("", selection: $selectedGender){
                                    Text("Male").tag("Male")
                                    Text("Female").tag("Female")
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
                            } label: {
                                Text("Save")
                                    .fontWeight(.bold)
                                    .font(.callout)
                                    .frame(width: 100, height: 45, alignment: .center)
                                    .background(Color("WaterBlue"))
                                    .cornerRadius(8)
                                    .padding(.top, 330)
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
                                    .font(.title)
                                    .frame(width: 150, height: 35)
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
                    .listRowBackground(Color("WaterBlue").opacity(0))
                    .foregroundStyle(Color.white)
                    
                }
                .background(Color("BackgroundYellow"))
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Biodata")
                            .font(.title)
                            .foregroundColor(Color("WaterBlue"))
                            .fontWeight(.heavy)
                            .padding(.top, 50)
                    }
                }

            }
        }
    }
}

#Preview {
    BiodataView(name: "", weight: "", age: "", selectedGender: "", fasting: false)
}
