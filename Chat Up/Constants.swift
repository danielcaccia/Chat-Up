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
    static let signUpSegue = "SignUpToChat"
    static let signInSegue = "SignInToChat"
    
    struct BrandColors {
        static let btnColor = "Button Color"
        static let chatBG = "Chat Background"
        static let chatBal = "Chat Baloons"
        static let msgText = "Message Text"
        static let genBG = "General Background"
    }
    
    struct Fstore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
