//
//  MessageCell.swift
//  Chat Up
//
//  Created by Daniel Caccia on 09/02/21.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        roundBorders()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func roundBorders() {
        self.messageBubble.layer.cornerRadius = 15
        self.messageBubble.clipsToBounds = true
        self.messageBubble.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
}
