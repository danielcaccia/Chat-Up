//
//  ContactsViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 28/02/22.
//

import UIKit

class ContactsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Contacts"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSession.shared.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.contactCell, for: indexPath) as! ContactCell
        let contact = UserSession.shared.contacts[indexPath.row]
        let name = "\(contact.firstName) \(contact.lastName)"
        
        cell.config(with: name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: K.StoryboardIDs.mainStoryboard, bundle: nil)
        let ChatsViewController = mainStoryboard.instantiateViewController(withIdentifier: K.StoryboardIDs.chatsView)
        let contact = UserSession.shared.contacts[indexPath.row]
        
        Coordinator.shared.presentNewController(currentViewController: ChatsViewController, storyboardName: K.StoryboardIDs.mainStoryboard, viewControllerID: K.StoryboardIDs.chatView, isModal: false, optionalObject: contact)
    }

}
