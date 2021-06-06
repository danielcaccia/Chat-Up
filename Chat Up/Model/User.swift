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
    let uid: String
    let contacts: [Contact]?
    
    init(_ userName: String, _ email: String, _ uid: String, _ contacts: [Contact]) {
        self.userName = userName
        self.email = email
        self.uid = uid
        self.contacts = contacts
    }
    
    struct Contact {
        
        let contactId: String
        let chatId: String?
        
        init(_ contactId: String, _ chatId: String) {
            self.contactId = contactId
            self.chatId = chatId
        }
        
    }
    
}
