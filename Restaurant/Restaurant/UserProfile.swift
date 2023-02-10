//
//  UserProfile.swift
//  Restaurant
//
//  Created by Toni Mikut on 04.02.23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    @State private var userImage = UserDefaults.standard.string(forKey: kUserImage) ?? ""
    
    
    @StateObject private var myNotifications =   AllNotifications()
    
    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.title)
            Form {
                Section("Avatar") {
                    Image(userImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
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
                Section("Phone number") {
                    TextField("Phone number", text: $phoneNumber)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
                Section("Email notifications") {
                    ForEach(myNotifications.notifications) { item in
                        Button {
                            let newNotification = SingleNotification(item.name, !item.isOn)
                            myNotifications.update(notification: newNotification)
                        } label: {
                            Label(item.name.rawValue, systemImage: item.isOn ? "checkmark.square" : "square")
                        }
                        .listRowSeparator(.hidden)
                    }
                    .foregroundColor(.black)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                Profile.logOutUser()
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Log out")
                    .padding()
                    .frame(width: 300)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .bold()
                    .cornerRadius(8)
            }
            HStack {
                Button {
                    firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    email = UserDefaults.standard.string(forKey: kEmail) ?? ""
                    phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
                    myNotifications.reset()
                } label: {
                    Text("Discard changes")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.black, lineWidth: 1)
                        )
                }
                Button {
                    Profile.changeUserData(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, userImage: userImage)
                    myNotifications.save()
                } label: {
                    Text("Save change")
                        .padding()
                        .background(.green)
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
