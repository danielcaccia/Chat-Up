//
//  Message.swift
//  Chat Up
//
//  Created by Daniel Caccia on 09/02/21.
//

import Foundation

struct Message {
    
    let sender: String
    let body: String
    let messageAt: Double
    
    init (_ sender: String, _ body: String, _ messageAt: Double) {
        self.sender = sender
        self.body = body
        self.messageAt = messageAt
    }
    
}
