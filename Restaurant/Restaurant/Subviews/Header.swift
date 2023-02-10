//
//  Header.swift
//  Restaurant
//
//  Created by Toni Mikut on 09.02.23.
//

import SwiftUI

struct Header: View {
    let showProfileImage: Bool
    var body: some View {
        HStack {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
            if showProfileImage {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }

        }
        .padding()
        .frame(height: 50)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(showProfileImage: true)
    }
}
