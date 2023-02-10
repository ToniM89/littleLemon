//
//  Profile.swift
//  Restaurant
//
//  Created by Toni Mikut on 10.02.23.
//

import Foundation

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kPhoneNumber = "kPhoneNumber"
let kUserImage = "kUserImage"
let kNotifications = "kNotifications"

let kIsLoggedIn = "kIsLoggedIn"

enum Notification : String, CaseIterable {
    case orderStatus = "Order Status"
    case passwordChanges = "Password changes"
    case specialOffers = "Special offers"
    case newsLetter = "Newsletter"
}

struct Profile {
    static func loginUser(firstName: String, lastName: String, email: String) {
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set("profile-image-placeholder", forKey: kUserImage)
        
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
    }

    static func changeUserData(firstName: String, lastName: String, email: String, phoneNumber: String, userImage: String) {
        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
        UserDefaults.standard.set(userImage, forKey: kUserImage)
    }
    
    static func logOutUser() {
        UserDefaults.standard.set("", forKey: kPhoneNumber)
        UserDefaults.standard.set("profile-image-placeholder", forKey: kUserImage)
    
        for notification in Notification.allCases {
            UserDefaults.standard.set(false, forKey: notification.rawValue)
        }
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
    }
}


