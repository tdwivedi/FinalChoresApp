//
//  multipleGroupsViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/16/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class multipleGroupsViewController: UIViewController {
    
    @IBOutlet weak var multipleGroupsTableView: UITableView!
    
    var memberName: String = ""
    var multipleMemberNames: [String] = []
    //var manageGroupWayNames: [String] = []
    
    var selectedGroup:Group!
    
    var groups: Results<Group>! {
        didSet {
            // Whenever groups update, update the table view
            multipleGroupsTableView?.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let realm = Realm()
        groups = realm.objects(Group)
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        multipleGroupsTableView.dataSource = self
        multipleGroupsTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            let realm = Realm()
            switch identifier {
            case "Done":
                let source = segue.sourceViewController as! createNewGroupViewController
                realm.write() {
                    source.currentGroup = Group()
                    source.currentGroup?.groupName = source.newGroupName.text
                    realm.add(source.currentGroup!)
                    
                    var membersList = split(source.newMemberName.text) {$0 == ","}
                    self.multipleMemberNames = membersList
                }
            case "Delete":
                realm.write() {
                    realm.delete(self.selectedGroup!)
                
                }
                let source = segue.sourceViewController as! groupViewController
                source.group = nil;
            default:
                println("No one loves \(identifier)")
            }
            groups = realm.objects(Group)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowCurrentGroup") {
            let destination = segue.destinationViewController as! groupViewController
            destination.group = selectedGroup
            destination.addedMembersNames = multipleMemberNames
        }
    }


}

extension multipleGroupsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupTableViewCell", forIndexPath: indexPath) as! GroupTableViewCell //1
        
        let row = indexPath.row
        let group = groups[row] as Group
        cell.group = group
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(groups?.count ?? 0)
    }
    
}

extension multipleGroupsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedGroup = groups[indexPath.row]
        
        /*for group in groups {
            //titleTest =  task.title
            selectedGroup = group
        }*/
        
        self.performSegueWithIdentifier("ShowCurrentGroup", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let group = groups[indexPath.row] as Object
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(group)
            }
            
            groups = realm.objects(Group)
        }
    }
    
}