//
//  User.swift
//  Chat Up
//
//  Created by Daniel Caccia on 06/06/21.
//

import Foundation

struct User {
    
    let userName: String
    let email: String
    let contacts: [Contact]?
    
    init(_ userName: String, _ email: String, _ contacts: [Contact]?) {
        self.userName = userName
        self.email = email
        self.contacts = contacts
    }
    
}

struct Contact {
    
    let contactId: String
    let userName: String
    let lastMessageAt: Double?
    let lastMessage: String?
    let messagesId: String?
    
    init(_ contactId: String, _ userName: String, _ lastMessageAt: Double?, _ lastMessage: String?, _ messagesId: String?) {
        self.contactId = contactId
        self.userName = userName
        self.lastMessageAt = lastMessageAt
        self.lastMessage = lastMessage
        self.messagesId = messagesId
    }
    
}
