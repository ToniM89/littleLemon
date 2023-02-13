//
//  MenuBreakdown.swift
//  Restaurant
//
//  Created by Toni Mikut on 10.02.23.
//

import SwiftUI

struct MenuBreakdown: View {
    
    @Binding var category: MenuCategory
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order for delivery!")
                .bold()
                .textCase(.uppercase)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(MenuCategory.allCases, id: \.rawValue) { category in
                        Button {
                            self.category = category
                        } label: {
                            Text("\(category.rawValue)")
                                .font(.callout)
                                .padding()
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(.secondary4)
                                .clipShape(Capsule())
                                .lineLimit(1)
                        }
                    }
                }
                
            }
        }
        .padding(.horizontal, 5)
    }
}

struct MenuBreakdown_Previews: PreviewProvider {
    static var previews: some View {
        MenuBreakdown(category: .constant(.all))
    }
}
