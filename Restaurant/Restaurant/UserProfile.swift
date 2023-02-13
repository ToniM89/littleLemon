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
                    HStack {
                        Image(userImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Button {
                            userImage = "profile-image-placeholder"
                        } label: {
                            Text("Restore")
                                .padding()
                                .background(.primary1)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .cornerRadius(8)
                        }
                        .disabled(userImage != "")
                        Button {
                            userImage = ""
                        } label: {
                            Text("Remove")
                                .padding()
                                .background(.white)
                                .foregroundColor(.secondary4)
                                .border(.secondary4)
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
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
                HStack {
                    Spacer()
                    Text("Log out")
                    Spacer()
                }
                .padding()
                .background(.yellow)
                .foregroundColor(.white)
                .bold()
                .cornerRadius(8)
            }
            .padding(.horizontal)
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
                        .foregroundColor(.secondary4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.secondary4, lineWidth: 1)
                        )
                }
                Button {
                    Profile.changeUserData(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, userImage: userImage)
                    myNotifications.save()
                } label: {
                    Text("Save change")
                        .padding()
                        .background(.primary1)
                        .foregroundColor(.white)
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
