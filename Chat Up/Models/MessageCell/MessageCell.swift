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
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundBorders()
    }

    func config(message: String, isSender: Bool) {
        messageLabel.text = message
        
        if isSender {
            leftConstraint.isActive = false
        } else {
            rightConstraint.isActive = false
        }
    }
    
    func roundBorders() {
        self.messageBubble.layer.cornerRadius = 15
        self.messageBubble.clipsToBounds = true
        self.messageBubble.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
}
