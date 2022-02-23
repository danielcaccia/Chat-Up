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
    let chats: [Chat]?
    
}

struct Contact: Codable {
    
    let uid: String
    let firstName: String
    let lastName: String
    
}
