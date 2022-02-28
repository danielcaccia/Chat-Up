//
//  UserSession.swift
//  Chat Up
//
//  Created by Daniel Caccia on 23/02/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit

class UserSession {
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var contacts = [Contact]()
    var chats = [Chat]()
    
    static let shared = UserSession()
    
    func fetchUserSession() {
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        db.collection(K.Fstore.usersCollectionName).document(currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving data from Firestore: \(error)")
            } else {
                guard let document = try! querySnapshot?.data(as: User.self) else {
                    print("Error parsing data from Firestore")
                    return
                }

                self.firstName = document.firstName
                self.lastName = document.lastName
                self.email = document.email
                
                if let contactList = document.contacts {
                    // Fetch Contact info
                    for contact in contactList {
                        db.collection(K.Fstore.usersCollectionName).document(contact.key).addSnapshotListener { (querySnapshot, error) in
                            
                            self.contacts = []
                            
                            if let err = error {
                                print("Error retrieving data from Firestore: \(err)")
                            } else {
                                guard let document = try! querySnapshot?.data(as: User.self) else {
                                    print("Error parsing data from Firestore")
                                    return
                                }
                                
                                let uid = contact.key
                                let firstName = document.firstName
                                let lastName = document.lastName
                                let chatID = contact.value
                                
                                self.contacts.append(Contact(with: uid, firstName, lastName, chatID))
                                
                                // Fetch Chat info
                                if chatID != "" {
                                    var messages = [Message]()
                                    
                                    db.collection(K.Fstore.messagesCollectionName).document(chatID).addSnapshotListener { (querySnapshot, error) in
                                        if let err = error {
                                            print("Error retrieving data from Firestore: \(err)")
                                        } else {
                                            guard let document = try! querySnapshot?.data(as: Chat.self) else {
                                                print("Error parsing data from Firestore")
                                                return
                                            }
                                            
                                            
                                            
                                            if let safeMessages = document.messages {
                                                for message in safeMessages {
                                                    let sender = message.sender
                                                    let body = message.body
                                                    let messaggeAt = message.messageAt
                                                    
                                                    messages.append(Message(with: sender, body, messaggeAt))
                                                }
                                            }
                                        }
                                    }
                                    
                                    self.chats.append(Chat(with: chatID, messages))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
