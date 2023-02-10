//
//  Onboarding.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import SwiftUI



struct Onboarding: View {
    
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @State private var isLoggedIn = false
    
    @State private var showingAlert = false
    
    private var filledOutAllFields: Bool {
        return !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Header(showProfileImage: false)
                HeroView(searchText: .constant(""), showSearchbar: false)
                Form {
                    Section("First Name*") {
                        TextField("First Name", text: $firstName)
                            .disableAutocorrection(true)
                    }
                    Section("Last Name*") {
                        TextField("Last Name", text: $lastName)
                            .disableAutocorrection(true)
                    }
                    Section("Email*") {
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                    }
                   
                   
                }
                Button {
                    if filledOutAllFields {
                        Profile.loginUser(firstName: firstName, lastName: lastName, email: email)
                        isLoggedIn = true
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Text("Login in")
                        .padding()
                        .frame(width: 300)
                        .background(.yellow)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(8)
                }
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                Spacer()
            }
            .onAppear {
                isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            }
            .alert("Important message", isPresented: $showingAlert) {
                       Button("OK", role: .cancel) { }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
