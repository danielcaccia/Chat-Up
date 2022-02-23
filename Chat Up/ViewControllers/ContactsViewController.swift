//
//  ContactsViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 06/06/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ContactsViewController: UITableViewController {

    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Contacts"
        tableView.separatorStyle = .none
        
        
    }
    
    @IBAction func newChatButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func newGroupButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func addContactButtonPressed(_ sender: UIButton) {
    }
    
    
//MARK: - Firestore Data Manipulation
    
    func fetchContacts() {
        db.collection("users").document(currentUser!.uid).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving data from Firestore: \(error)")
            } else {
                guard let document = try! querySnapshot?.data(as: User.self), let hasContacts = document.contacts else {
                    print("Couldn't find any contacts")
                    return
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func saveContact(_ contact: Contact) {
        do {
//            try db.collection("users").document(currentUser!.uid).setData(from: contact)
        } catch let error {
            print("Error writing contact to Firestore: \(error)")
        }

        tableView.reloadData()
    }
    
    func searchUser(with email: String) -> Contact? {
        var contact: Contact?
        
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving data from Firestore: \(error)")
            } else {
                if !querySnapshot!.documents.isEmpty {
                    if let user = try! querySnapshot!.documents.first!.data(as: User.self) {
                        let uid = user.id!
                        let firstName = user.firstName
                        let lastName = user.lastName
                        
                        contact = Contact(uid: uid, firstName: firstName, lastName: lastName)
                    }
                }
            }
        }

        return contact
    }
    
//MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.contactCell, for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
//        cell.detailTextLabel?.text = contact.lastMessage ?? ""
        
        return cell
    }
 
//MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.contactsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        send contact object to load messages on next VC
    }
    
}
