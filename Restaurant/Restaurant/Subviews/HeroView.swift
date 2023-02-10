//
//  HeroView.swift
//  Restaurant
//
//  Created by Toni Mikut on 09.02.23.
//

import SwiftUI

struct HeroView: View {
    
    @Binding var searchText: String
    var showSearchbar = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .foregroundColor(.yellow)
                .font(.title)
            Text("Chicago")
                .foregroundColor(.white)
                .font(.headline)
            HStack {
                Text("Das ist ein sehr langer Text den man auf meheren Zeilen anzeigen muss das ist aber auch Kein Problem, weil das von alleine passiert, da ist swift sehr schlau. Bevor man das abgibt muss man den text aber noch anapassen.")
                Image("HeroImage")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                
            }
            if showSearchbar {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding([.leading], 5)
                       
                    TextField("Search menu", text: $searchText)
                        .padding(8)
                }
                .background(Capsule().fill(Color.white))
            }
        }
        .padding()
        .background(.green)
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView(searchText: .constant(""))
    }
}
