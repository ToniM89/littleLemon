//
//  Home.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import SwiftUI

struct Home: View {
    let persistance = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistance.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
