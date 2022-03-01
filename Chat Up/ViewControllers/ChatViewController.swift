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
        
        navigationItem.title = "ChatUp!"
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.chatBubbleCell)
        
        let contact = optionalObject as! Contact
        let chat = UserSession.shared.chats.filter { return $0.id == contact.chat }
        
        if let messages = chat.first?.messages {
            self.messages = messages
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.chatBubbleCell, for: indexPath) as! MessageCell
        
        cell.config(message: message.body, isSender: message.sender == currentUser?.uid)
        
        return cell
    }
    
}
