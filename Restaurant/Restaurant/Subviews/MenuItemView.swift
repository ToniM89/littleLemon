//
//  MenuItemView.swift
//  Restaurant
//
//  Created by Toni Mikut on 10.02.23.
//

import SwiftUI

struct MenuItemView: View {
    
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(dish.title!)")
                .bold()
            HStack {
                VStack(alignment: .leading) {
                    Text("\(dish.detailText ?? "")")
                        .font(.footnote)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                    Text(Int(dish.price!)!, format: .currency(code: "USD"))
                }
                Spacer()
                AsyncImage(url: URL(string: dish.image!)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}
