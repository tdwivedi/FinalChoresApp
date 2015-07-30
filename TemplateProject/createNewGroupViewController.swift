//
//  createNewGroupViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/16/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class createNewGroupViewController: UIViewController {

    @IBOutlet weak var newGroupName: UITextField!
    
    @IBOutlet weak var newMemberName: UITextField!
    
    @IBOutlet weak var newMemberPhone: UITextField!
    
    @IBOutlet weak var addMemberButton: UIButton!
    
    @IBAction func addMemberButtonTapped(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var doneButton: UIButton!
    
    var currentGroup: Group?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let realm = Realm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGroupName.delegate = self
        newMemberName.delegate = self
        newMemberPhone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //var addedGroup: Group?
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "ShowNewGroup") {
    currentGroup = Group()
    currentGroup?.groupName = newGroupName.text
    let destination = segue.destinationViewController as! groupViewController
    destination.group = currentGroup
    
    /* addedGroup = Group()
    addedGroup!.groupName = newGroupName.text
    let realm = Realm()
    realm.write() {
    realm.add(self.addedGroup!)
    }
    destination.groups = realm.objects(Group)
    
    //destination.memberName = newMemberName.text
    //  println(destination.memberName)
    var membersList = split(newMemberName.text) {$0 == ","}
    destination.multipleMemberNames = membersList*/
    }
    }*/

}

extension createNewGroupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
