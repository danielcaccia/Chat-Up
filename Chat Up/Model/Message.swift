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
    let date: Date
    
    init (_ sender: String, _ body: String, _ time: Date) {
        self.sender = sender
        self.body = body
        date = time
    }
    
}
