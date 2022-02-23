//
//  Message.swift
//  Chat Up
//
//  Created by Daniel Caccia on 09/02/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Chat: Identifiable, Codable {
    
    @DocumentID var id: String?
    let messages: [Message]?
    
}

struct Message: Codable {
    
    let sender: String
    let body: String
    let messageAt: Double
    
    init (_ sender: String, _ body: String, _ messageAt: Double) {
        self.sender = sender
        self.body = body
        self.messageAt = messageAt
    }
    
}
