//
//  ModalView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct ModalView: View {
    
    @State var biodata = Biodata()
    @State var preferences = Preferences()
    
    var body: some View {
        ZStack{
            Color("WaterBlue")
                .ignoresSafeArea()
        VStack {
            VStack{
                Text("Your daily water goal is")
                    .bold()
                    .foregroundStyle(Color.white)
                Text("\(preferences.waterIntake) mL") //Switch with Volume var
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
                        .foregroundStyle(Color.white)
                    VStack{
                        Text("⏰")
                            .font(.system(size: 44))
                            .padding(.bottom, 2)
                        Text("\(preferences.interval) mins") //Switch with Interval var
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
                        .foregroundStyle(Color.white)
                    VStack{
                        Text("💧")
                            .font(.system(size: 44))
                            .padding(.bottom, 2)
                        Text("\(preferences.sipCapacity, specifier: "%.0f") mL") //Switch with Interval var
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
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .foregroundStyle(Color.white)
                HStack{
                    Image("glassOfWater")
                    Text(" x \(preferences.sipCapacityGlass, specifier: "%.1f")")
                        .fontWeight(.heavy)
                        .padding(.vertical)
                        .font(.system(size: 44))
                        .foregroundColor(Color.white)
                }
                
            }
            }
        }
    }
}

#Preview {
    ModalView()
}
