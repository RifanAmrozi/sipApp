//
//  MenuView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack{
                ZStack{
                    Color("BackgroundYellow")
                        .ignoresSafeArea()
                    VStack{
//                    TODO: Set real data here
                        NavigationLink(destination: BiodataView(name: "", weight: 0, age: 0, selectedGender: "", fasting: false)){
                            VStack{
                                Text("Biodata")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                    
                                Text("Edit your personal information for a more up-to-date water intake goal")
                            }
                            .padding(40)
                            .foregroundStyle(Color.white)
                            .frame(width: 350, height: 300)
                            .background(Color("WaterBlue"))
                            .cornerRadius(15)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(.center)
                        }
                        
                        NavigationLink(destination: PreferencesView()){
                            VStack{
                                Text("Preferences")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                
                                Text("Personalize your application and reminder")
                            }
                            .padding(40)
                            .foregroundStyle(Color("WaterBlue"))
                            .frame(width: 350, height: 300)
                            .background(Color.white)
                            .cornerRadius(15)
                            .multilineTextAlignment(.center)
                        }
                    }
                    
                }
        }
        
    }
}

#Preview {
    MenuView()
}
