//
//  Onboarding.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @State private var isLoggedIn = false
    
    private var filledOutAllFields: Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("First Name", text: $firstName)
                    .disableAutocorrection(true)
                TextField("Last Name", text: $lastName)
                    .disableAutocorrection(true)
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Button("Register") {
                    if(filledOutAllFields) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    } else {
                        print("Please fill out all fields...")
                    }
                }
            }
            .padding()
            .onAppear {
                isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
