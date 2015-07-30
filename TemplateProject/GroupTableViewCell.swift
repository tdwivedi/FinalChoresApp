//
//  GroupTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/16/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    
    var group: Group? {
        didSet {
            if let group = group, groupNameLabel = groupNameLabel {
                self.groupNameLabel.text = group.groupName
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
