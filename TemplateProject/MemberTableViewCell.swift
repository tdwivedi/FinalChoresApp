//
//  MemberTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberNameLabel: UILabel! {
        didSet {
            if let member = member, memberNameLabel = memberNameLabel {
                self.memberNameLabel.text = member
            }
        }
    }
    
/*var member: Member? {
    didSet {
        if let member = member, memberNameLabel = memberNameLabel {
            self.memberNameLabel.text = member.memberName
        }
    }
}*/


    var member: String? {
        didSet {
            if let member = member, memberNameLabel = memberNameLabel {
                self.memberNameLabel.text = member
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
