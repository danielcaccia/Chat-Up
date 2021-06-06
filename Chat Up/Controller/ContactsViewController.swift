//
//  ContactsViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 05/06/21.
//

import UIKit
import Firebase

class ContactsViewController: UIViewController {

    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var contacts: [User.Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - UITableViewDataSource Methods
//extension ContactsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
