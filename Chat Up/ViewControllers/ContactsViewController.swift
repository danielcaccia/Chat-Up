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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Contacts"
        
        tableView.separatorStyle = .none
    }
    
    @IBAction func newChatButtonPressed(_ sender: UIBarButtonItem) {
        // Create new "Chats" document and save it on UserSession within the correct contact
    }
    
    @IBAction func newGroupButtonPressed(_ sender: UIButton) {
        // TBD
    }
    
    @IBAction func addContactButtonPressed(_ sender: UIButton) {
        var emailTextField = UITextField()
        
        emailTextField.textContentType = .emailAddress
        
        let alert = UIAlertController(title: "Add Contact", message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .default) { addButton in
            if let email = emailTextField.text {
                self.db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error retrieving data from Firestore: \(error)")
                        
                        let errorLabel = UILabel()
                        
                        errorLabel.text = "\(error.localizedDescription)"
                        errorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
                    } else {
                        if !querySnapshot!.documents.isEmpty {
                            if let safeDocument = try! querySnapshot!.documents.first!.data(as: User.self) {
                                let uid = safeDocument.id!
                                let firstName = safeDocument.firstName
                                let lastName = safeDocument.lastName
                                let contact = Contact(with: uid, firstName, lastName, nil)
                                
                                UserSession.shared.contacts.append(contact)
                                
                                self.db.collection(K.Fstore.usersCollectionName).document(self.currentUser!.uid).updateData([
                                    K.Fstore.contactsField: [uid: ""]
                                ]) { err in
                                    if let err = error {
                                        print("Error saving data to Firestore: \(err)")
                                    } else {
                                        print("Data saved to Firestore.")
                                    }
                                }
                            }
                        } else {
                            // Alert there's no user with that e-mail
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                }
            }
            
        }
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter e-mail address"
            emailTextField = textField
        }

        self.present(alert, animated: true, completion: nil)
    }
    
//MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSession.shared.chats.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.headerCell, for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.chatCell, for: indexPath)
            let chat = UserSession.shared.chats[indexPath.row - 1]
            let contact = UserSession.shared.contacts.filter { return chat.id == $0.chat }.first!
            
            cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
            cell.detailTextLabel?.text = chat.messages?.last?.body ?? ""
            
            return cell
        }
    }
 
//MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            Coordinator.shared.presentNewController(currentViewController: self, storyboardName: K.StoryboardIDs.mainStoryboard, viewControllerID: K.StoryboardIDs.chatView, isModal: false, optionalObject: nil)
        }
    }
    
}
