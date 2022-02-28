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
    let contacts: [String: String]?
    
    init(with id: String, _ firstName: String, _ lastName: String, _ email: String, _ contacts: [String: String]?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contacts = contacts
    }
    
}
