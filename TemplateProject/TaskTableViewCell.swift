//
//  TaskTableViewCell.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

//var isChecked:Bool?
//var isChecked = checked

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var checked:Bool?
    //var checked = isChecked
    
    @IBOutlet weak var checkboxButton: UIButton!
    
    
    @IBAction func checkButton(sender: AnyObject) {
        if !checked! {
            checkboxButton.setImage(UIImage(named: "checked_box"), forState: .Normal)
            checked = true
        }
        else {
            checkboxButton.setImage(UIImage(named: "checkbox"), forState: .Normal)
            checked = false
        }
    }

    
    var task: Task? {
        didSet {
            if let task = task, taskLabel = taskLabel, timeLabel = timeLabel {
                println(task.title)
                 println(task.content)
                 println(task.endDate)
                  self.taskLabel.text = task.title
                //self.taskLabel.text = titleTextField.text
                self.timeLabel.text = task.endDate
            }
        }
    }

}
