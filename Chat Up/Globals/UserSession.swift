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
    var contacts: [Contact]? = nil
    var chats: [Chat]? = nil
    
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
                    for contact in contactList {
                        db.collection(K.Fstore.usersCollectionName).document(contact).addSnapshotListener { (querySnapshot, error) in
                            
                            self.contacts = []
                            
                            if let err = error {
                                print("Error retrieving data from Firestore: \(err)")
                            } else {
                                guard let document = try! querySnapshot?.data(as: User.self) else {
                                    print("Error parsing data from Firestore")
                                    return
                                }
                                
                                self.contacts?.append(Contact(uid: contact, firstName: document.firstName, lastName: document.lastName))
                            }
                        }
                    }
                }
                
                if let chatList = document.chats {
                    for chat in chatList {
                        db.collection(K.Fstore.messagesCollectionName).document(chat).addSnapshotListener { (querySnapshot, error) in
                            
                            self.chats = []
                            
                            if let err = error {
                                print("Error retrieving data from Firestore: \(err)")
                            } else {
                                guard let document = try! querySnapshot?.data(as: Chat.self) else {
                                    print("Error parsing data from Firestore")
                                    return
                                }
                                
                                self.chats?.append(document)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
