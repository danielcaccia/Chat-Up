//
//  ContactsViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 06/06/21.
//

import UIKit
import Firebase

class ContactsViewController: UITableViewController {

    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadContacts()
        
        tableView.separatorStyle = .none
    }

//MARK: - Firestore Data Manipulation
    func loadContacts() {
        db.collection("users").document(currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            if let documents = querySnapshot?.get("contacts") as? [String: Any] {
                for doc in documents {
                    let contents = doc.value as! [String: Any]
                    let contactId = doc.key
                    
                    let userName = contents["userName"] as! String
                    let lastMessageAt = contents["lastAt"] as? Double
                    let lastMessage = contents["last"] as? String
                    let messagesId = contents["messId"] as? String
                        
                    self.contacts.append(Contact(contactId, userName, lastMessageAt, lastMessage, messagesId))
                }

                self.contacts.sort {
                    $0.lastMessageAt ?? 0 > $1.lastMessageAt ?? 0
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
//MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.contactCell, for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.userName
        cell.detailTextLabel?.text = contact.lastMessage ?? ""
        
        return cell
    }
    
}
