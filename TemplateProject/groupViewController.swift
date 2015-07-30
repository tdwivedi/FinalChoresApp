//
//  groupViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/13/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import RealmSwift

//Lists Members of a Group . . .
class groupViewController: UIViewController {

    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var groupTableView: UITableView!
    
    //var addedMemberName: String = ""
    var addedMembersNames: [String] = []
    
    var group: Group? {
        didSet {
            //displayGroup(addedMembersNames)
        }
    }
    
    func displayGroup(membersNames: [String]) {
        if let group = group  {
            let realm = Realm()
                for name in membersNames
                {
                    let newMember = Member()
                    newMember.memberName = name
                    realm.write() {
                        realm.add(newMember)
                    }
                }
                members = realm.objects(Member)
            
            /*if count(note.title)==0 && count(note.content)==0 { //if there is no content, we assume Edit mode
                titleTextField.becomeFirstResponder()
            }*/
        }
    }
    
    var selectedMember:Member!
    
    var members: Results<Member>! {
        didSet {
            // Whenever notes update, update the table view
            groupTableView?.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        /*let realm = Realm()
        if let group = self.group {
            for name in addedMembersNames
             {
                let newMember = Member()
                newMember.memberName = name
                realm.write() {
                    realm.add(newMember)
                }
            }
            members = realm.objects(Member)
        }*/
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.dataSource = self
        groupTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        saveGroup()
//    }
//    
//    func saveGroup() {
//        /*if let group = group {
//            let realm = Realm()
//            
//            realm.write {
//                if (note.title != self.titleTextField.text || note.content != self.contentTextView.textValue) {
//                    note.title = self.titleTextField.text
//                    note.content = self.contentTextView.textValue
//                    note.modificationDate = NSDate()
//                }
//            }
//        }*/
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            let realm = Realm()
            switch identifier {
            case "AddMember":
                let source = segue.sourceViewController as! NewMemberViewController
                source.currentMember = Member()
                var newName = source.currentMember?.memberName
                newName = source.newMemberNameLabel.text
                addedMembersNames.append(newName!)
                realm.write() {
                    realm.add(source.currentMember!)
                }
            case "Delete":
                realm.write() {
                    realm.delete(self.selectedMember!)
                }
                
                let source = segue.sourceViewController as! taskListViewController
                source.member = nil;
                
            default:
                println("No one loves \(identifier)")
            }
            
            members = realm.objects(Member)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowExistingMember") {
            let destination = segue.destinationViewController as! taskListViewController
            destination.member = selectedMember
        }
    }
}

extension groupViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberTableViewCell", forIndexPath: indexPath) as! MemberTableViewCell
        
        let row = indexPath.row
        let member = members[row] as Member //String
        cell.member = member.memberName

        //cell.member = addedMemberName
        //addedMemberName = cell.member!
        println(row)
        
        /////cell.member?.memberName = addedMembersNames[row]
        cell.member = addedMembersNames[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //members?.count = addedMembersNames.count
        return addedMembersNames.count//3//Int(members?.count ?? 0)
    }
    
}

extension groupViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMember = members[indexPath.row]
        /*for member in members {
            selectedMember = member
        }*/
        self.performSegueWithIdentifier("ShowExistingMember", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
}
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let member = members[indexPath.row] as Object
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(member)
            }
            
            members = realm.objects(Member)
        }
    }
    
}

