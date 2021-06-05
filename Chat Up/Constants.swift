//
//  Constants.swift
//  Chat Up
//
//  Created by Daniel Caccia on 08/02/21.
//

import Foundation

struct K {
    
    static let appName = "ChatUp!"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let signUpSegue = "SignUpToContacts"
    static let signInSegue = "SignInToContacts"
    static let contactsSegue = "ContactsToChat"
    
    struct BrandColors {
        static let btnColor = "Button Color"
        static let chatBG = "Chat Background"
        static let chatBal = "Chat Baloons"
        static let msgText = "Message Text"
        static let genBG = "General Background"
    }
    
    struct Fstore {
        static let connectionsCollectionName = "connections"
        static let messagesCollectionName = "messages"
        static let senderField = "sender"
        static let receiverField = "receiver"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
