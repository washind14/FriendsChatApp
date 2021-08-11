//
//  Constants.swift
//  FriendsChatApp
//
//  Created by Desha Washington on 6/30/21.
//

import Foundation

    struct K {
    static let signUpSegue = "signUpToChat"
    static let loginSegue = "loginToChat"
    static let homeSegue = "homeScreen"
    static let cellIdentifier = "reusableCell"
    static let cellNibName = "MessagesTableViewCell"
    

    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
