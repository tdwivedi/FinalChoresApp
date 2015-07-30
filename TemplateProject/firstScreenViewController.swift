//
//  ViewController.swift
//  Template Project
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse
import RealmSwift
import ConvenienceKit

//Home View Controller . . .
class firstScreenViewController: UIViewController {

    @IBOutlet weak var allTasksTableView: UITableView!
    
    var selectedTask:Task!
    
    var allMyTasks: Results<Task>! {
        didSet {
            // Whenever notes update, update the table view
            allTasksTableView?.reloadData()
        }
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier {
                    
                        let source = segue.sourceViewController as! createNewGroupViewController
                    
            println("Identifier \(identifier)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ManageAllGroups" {
            var destination: multipleGroupsViewController = segue.destinationViewController as! multipleGroupsViewController
            
            //doesn't save member names
        }
        else if segue.identifier == "CreateNewGroup" {
            //this process works
        }
    }

}

extension firstScreenViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyTaskCell", forIndexPath: indexPath) as! TaskTableViewCell
        
        let row = indexPath.row
        let task = allMyTasks[row] as Task
        cell.task = task
        
        cell.checked = false
        //currentCell.checked = false
        /*var currentCell = cell
        if currentCell.checked! {
        if deleteTasksButton.isFirstResponder() {
        delete(currentCell)
        }//enabled
        
        }*/
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(allMyTasks?.count ?? 0)
    }
    
}

extension firstScreenViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = allMyTasks[indexPath.row]
        
        println(indexPath.row)
        for task in allMyTasks {
            selectedTask = task
        }
        self.performSegueWithIdentifier("ShowExistingTask", sender: self)
    }
    
    // 3
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let task = allMyTasks[indexPath.row] as Object
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(task)
            }
            
            //tasks = realm.objects(Task).sorted("endDate", ascending: false)
            allMyTasks = realm.objects(Task)
        }
    }
    
}
