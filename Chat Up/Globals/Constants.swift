//
//  Constants.swift
//  Chat Up
//
//  Created by Daniel Caccia on 08/02/21.
//

import Foundation

struct K {
    
    static let appName = "ChatUp!"
    static let headerCell = "HeaderCell"
    static let chatCell = "ChatCell"
    static let chatReusableCell = "ChatReusableCell"
    static let cellNibName = "MessageCell"
    static let signUpSegue = "SignUpToContacts"
    static let signInSegue = "SignInToContacts"
    static let contactsSegue = "ContactsToChat"
    static let alignConstraintId = "bubbleAlignment"
    
    struct StoryboardIDs {
        
        static let mainStoryboard = "Main"
        static let contactsView = "ContactsView"
        static let chatView = "ChatView"
        
    }
    
    struct BrandColors {
        
        static let btnColor = "Button Color"
        static let chatBG = "Chat Background"
        static let chatBal = "Chat Baloons"
        static let msgText = "Message Text"
        static let genBG = "General Background"
        
    }
    
    struct Fstore {
        
        static let usersCollectionName = "users"
        static let messagesCollectionName = "messages"
        
        static let firstNameField = "firstName"
        static let lastNameField = "lastName"
        static let emailField = "email"
        static let uidField = "uid"
        
        static let contactsField = "contacts"
        static let lastField = "lastMessage"
        static let lastAtField = "lastMessageAt"
        static let messagesIdField = "messagesId"
        
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "messageAt"
        
    }
    
}
