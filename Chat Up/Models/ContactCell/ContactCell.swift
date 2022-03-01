//
//  ContactCell.swift
//  Chat Up
//
//  Created by Daniel Caccia on 28/02/22.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(with name: String) {
        self.nameLabel.text = name
    }
    
}
