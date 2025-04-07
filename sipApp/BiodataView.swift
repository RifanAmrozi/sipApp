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
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
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
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Biodata")
                            .font(.title)
                            .foregroundColor(Color.black)
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
    BiodataView(name: "", weight: "", age: "", selectedGender: "", fasting: false)
}
