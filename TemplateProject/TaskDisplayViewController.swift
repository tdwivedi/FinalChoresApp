//
//  TaskDisplayViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/17/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ConvenienceKit
import Parse

class TaskDisplayViewController: UIViewController {
    
    //add alerts
    
   // var tableViewCell: TaskTableViewCell?
    
    var edit: Bool = false
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var titleForLabel:String!
    
    @IBOutlet weak var dateTextField: UITextField!

    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayTask(self.task)
        titleTextField.returnKeyType = .Next //renaming Return button on the keyboard to Next
        titleTextField.delegate = self //setting the titleTextField delegate
        dateTextField.delegate = self
        dateTextField.returnKeyType = .Next //renaming Return button on the keyboard to Next

        
        contentTextView.layer.cornerRadius = 5
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentTextView.layer.borderWidth = 1
        contentTextView.text = " "
        
        if edit {
            deleteButton.enabled = true//false
        }
    }
    
    override func viewDidLoad() {
        
        titleTextField.delegate = self
        dateTextField.delegate = self
        
        contentTextView.layer.cornerRadius = 5
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentTextView.layer.borderWidth = 1
        contentTextView.text = " "
    }
    
    var task: Task? {
        didSet {
            displayTask(task)
        }
    }
    
    func displayTask(task: Task?) {
        if let task = task, titleTextField = titleTextField, dateTextField = dateTextField, contentTextView = contentTextView  {
          
            titleTextField.text = task.title
            dateTextField.text = task.endDate
            contentTextView.text = task.content
            
            if count(task.title)==0 && count(task.endDate)==0 { //if there is no content, we assume Edit mode
                titleTextField.becomeFirstResponder()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveTask()
    }
    
    func saveTask() {
        if let task = task {
            let realm = Realm()
            
            realm.write {
                if (task.title != self.titleTextField.text || task.content != self.contentTextView.text || task.endDate != self.dateTextField.text) {
                    task.title = self.titleTextField.text
                    task.content = self.contentTextView.text
                    task.endDate = self.dateTextField.text
                }
            }
        //ParseHelper.addTaskToUserInGroup(PFUser.currentUser()!, group: Group())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TaskDisplayViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == dateTextField) {
            contentTextView.returnKeyType = .Done
            contentTextView.becomeFirstResponder()
        }
        return true
    }
}
