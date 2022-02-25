//
//  User.swift
//  Chat Up
//
//  Created by Daniel Caccia on 06/06/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let email: String
    var contacts: [Contact]?
    let chats: [String]?
    
    init(with id: String, _ firstName: String, _ lastName: String, _ email: String, _ contacts: [Contact]?, _ chats: [String]?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contacts = contacts
        self.chats = chats
    }
    
}

struct Contact: Codable {
    
    let uid: String
    let firstName: String
    let lastName: String
    let chat: String?
    let lastMessage: String?
    
    init(with uid: String, _ firstName: String, _ lastName: String, _ chat: String?, _ lastMessage: String?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.chat = chat
        self.lastMessage = lastMessage
    }
    
}
