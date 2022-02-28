//
//  Contact.swift
//  Chat Up
//
//  Created by Daniel Caccia on 26/02/22.
//

import Foundation

struct Contact {
    
    let uid: String
    let firstName: String
    let lastName: String
    let chat: String?
    
    init(with uid: String, _ firstName: String, _ lastName: String, _ chat: String?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.chat = chat
    }

}
