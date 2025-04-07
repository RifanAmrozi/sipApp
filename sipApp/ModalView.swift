//
//  ModalView.swift
//  Sip
//
//  Created by Keinan Wardhana on 26/03/25.
//

import SwiftUI

struct ModalView: View {
    @State var showModal = false
    
    var body: some View {
        Button("Save") {
            showModal = true
        }
        .sheet(isPresented: $showModal) {
            VStack {
                Text("Your Daily Goal is")
                    .bold()
                Text("2L.") //Switch with Volume var
                    .fontWeight(.heavy)
                    .padding(.vertical)
                    .font(.system(size: 44))
                    .foregroundColor(Color.cyan)
                Text("For Every")
                    .bold()
                Text("30 Minutes") //Switch with Interval var
                    .fontWeight(.heavy)
                    .padding(.vertical)
                    .font(.system(size: 44))
                    .foregroundColor(Color.cyan)
                Text("Equivalent to")
                    .bold()
                Text("🥛 x 3 1/2") //Switch with Freq var
                    .fontWeight(.heavy)
                    .padding(.vertical)
                    .font(.system(size: 44))
                    .foregroundColor(Color.cyan)
                Text("3 and a Half Glasses")
                    .fontWeight(.heavy)
                    .padding(.vertical)
                    .font(.system(size: 36))
                    .foregroundColor(Color.cyan)
            }
                Button {
                    //
                } label: {
                    Text("Sip!")
                }
                .fontWeight(.heavy)
                .font(.system(size: 36))
                .frame(width: 200, height: 40)
                .padding()
                .background(Color.cyan)
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .padding(.top, 50)
        }
    }
}

#Preview {
    ModalView()
}
