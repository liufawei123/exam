//
//  ContactTableViewCell.swift
//  exam
//
//  Created by Liu Fan Wei on 7/4/19.
//  Copyright © 2019 Liu Fan Wei. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(_ contact: ContactModel) {
        nameLabel.text = contact.fullName
    }
}
