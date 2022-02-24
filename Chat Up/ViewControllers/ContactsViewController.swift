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
    }
    
    @IBAction func newGroupButtonPressed(_ sender: UIButton) {
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
                            if let user = try! querySnapshot!.documents.first!.data(as: User.self) {
                                let uid = user.id!
                                let firstName = user.firstName
                                let lastName = user.lastName
                                
                                UserSession.shared.contacts.append(Contact(with: uid, firstName, lastName, nil, nil))
                                
                                self.db.collection(K.Fstore.usersCollectionName).addDocument(data: [
                                    K.Fstore.contactsField: [K.Fstore.uidField: uid,
                                                             K.Fstore.firstNameField: firstName,
                                                             K.Fstore.lastNameField: lastName]
                                ]) { (error) in
                                    if let err = error {
                                        print("Error saving data to Firestore: \(err)")
                                    } else {
                                        print("Data saved to Firestore.")
                                    }
                                }
                            }
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
        return UserSession.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.headerCell, for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.contactCell, for: indexPath)
            let contact = UserSession.shared.contacts[indexPath.row]
            
            cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
            cell.detailTextLabel?.text = contact.lastMessage ?? ""
            
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
