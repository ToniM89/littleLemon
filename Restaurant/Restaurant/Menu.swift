//
//  Menu.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var dataLoaded = false
    
    var body: some View {
        VStack {
            Text("Little lemon")
            Text("Chicago")
            Text("TODO: Place short description here.")
            FetchedObjects() { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack {
                            Text("\(dish.title ?? "No name dish") \(dish.price ?? "0.00")")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.resizable()
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }
        .onAppear {
            if(!dataLoaded) {
                dataLoaded = true
                getMenuData()
            }
                    }
    }
    
    func getMenuData() {
        
        // clear database befor loading new data into it
        PersistenceController.shared.clear()
        
        // load new data from the server and store in database
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let request = URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data {
                let result = try? JSONDecoder().decode(MenuList.self, from: data)
                if let result {
                    for menuItem in result.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                    }
                    try? viewContext.save()
                }
            }
        }
        request.resume()
        
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
