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
                .foregroundColor(.primary2)
                .font(.custom("Markazi Text", size: 42))
            Text("Chicago")
                .foregroundColor(.white)
                .font(.custom("Markazi Text", size: 32))
                .padding(.bottom, -80)
            HStack {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .foregroundColor(.white)
                    .font(.custom("Karla", size: 16))
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
        .background(.primary1)
    }
}


struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView(searchText: .constant(""))
    }
}
