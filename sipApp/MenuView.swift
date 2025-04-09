//
//  MenuView.swift
//  sipApp
//
//  Created by Hany Wijaya on 26/03/25.
//

import SwiftUI

struct MenuView: View {
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    var body: some View {
        NavigationStack{
                ZStack{
                    Color("BackgroundYellow")
                        .ignoresSafeArea()
                    VStack{
                        NavigationLink(destination: BiodataView(biodata: biodata, preferences: preferences)) {
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
                        
                        
                        NavigationLink(destination: PreferencesView(biodata: biodata, preferences: preferences)){
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
