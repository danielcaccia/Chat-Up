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
    let contacts: [Contact]?
    let chats: [String]?
    
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
