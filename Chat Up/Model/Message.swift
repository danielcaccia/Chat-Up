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
    
    init (_ sender: String, _ body: String) {
        self.sender = sender
        self.body = body
    }
    
}
