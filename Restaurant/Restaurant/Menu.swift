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
    @State private var searchText = ""
    @State private var showedCategory: MenuCategory = .all
    
    var body: some View {
        VStack {
            Header(showProfileImage: true)
            HeroView(searchText: $searchText)
            MenuBreakdown(category: $showedCategory)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    if dishes.count == 0 {
                        Text("Sorry, we currently don't serve a menu item with your search terms :(")
                            .bold()
                    } else {
                        ForEach(dishes, id: \.self) { dish in
                            MenuItemView(dish: dish)
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
                        dish.detailText = menuItem.detailText
                        dish.category = menuItem.category
                        
                    }
                    try? viewContext.save()
                } else {
                    print("Data couldn't be interpreted")
                }
            }
        }
        request.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if showedCategory == .all {
            if searchText.isEmpty {
                return NSPredicate(value: true)
            }
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        if searchText.isEmpty {
            return NSPredicate(format: "category CONTAINS[cd] %@", showedCategory.rawValue)
        }
        return NSPredicate(format: "category CONTAINS[cd] %@ AND title CONTAINS[cd] %@", showedCategory.rawValue, searchText)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
