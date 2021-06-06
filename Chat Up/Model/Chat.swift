//
//  Chat.swift
//  Chat Up
//
//  Created by Daniel Caccia on 06/06/21.
//

import Foundation

struct Chat {
    
    let lastMessage: String
    let lastMessageAt: Double
    let messagesId: String
    
    init(_ lastMessage: String, _ lastMessageAt: Double, _ messagesId: String) {
        self.lastMessage = lastMessage
        self.lastMessageAt = lastMessageAt
        self.messagesId = messagesId
    }
    
}
