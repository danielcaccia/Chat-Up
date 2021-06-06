//
//  ChatViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 02/02/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        navigationItem.title = "ChatUp!"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.Fstore.messagesCollectionName).order(by: K.Fstore.dateField).addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let err = error {
                print("Error retrieving data from Firestore: \(err)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        if let sender = doc.data()[K.Fstore.senderField] as? String,
                           let body = doc.data()[K.Fstore.bodyField] as? String {
                            
                            print(doc.data())
                            self.messages.append(Message(sender, body, Date().timeIntervalSince1970))
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.Fstore.messagesCollectionName).addDocument(data: [
                K.Fstore.senderField: messageSender,
                K.Fstore.bodyField: messageBody,
                K.Fstore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let err = error {
                    print("Error saving data to Firestore: \(err)")
                } else {
                    print("Data saved to Firestore.")
                }
            }
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
            showAlert(with: signOutError.localizedDescription)
        }
    }
    
    func showAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDataSource Methods
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.messageLabel.text = message.body
        
        if message.sender == currentUser?.uid {
            
        } else {

        }
        
        return cell
    }
    
}
