//
//  taskListViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import RealmSwift

class taskListViewController: UIViewController {

    //var isCompleted = checked
    
    @IBOutlet weak var taskListTableView: UITableView!
    
    @IBOutlet weak var deleteTasksButton: UIButton!
    
    var titleTest:String!
    
    @IBAction func deleteDoneTasks(sender: AnyObject) {
        //var completedTasks = [Task]
        /*for aTask in tasks {
            if aTask.done
        }*/
        
       /* var cellsToBeDeleted = [TaskTableViewCell]()
        //for index in 0...taskListTableView.deleteRowsAtIndexPaths(, withRowAnimation: )
        for index in 0...taskListTableView.numberOfSections() {
            var path = NSIndexPath().indexPathByAddingIndex(index)
            if taskListTableView.cellForRowAtIndexPath(path)
        }*/
    }
    
    var selectedTask:Task!
    
    var member: Member? {
        didSet {
            //displayGroup(addedMembersNames)
        }
    }
    
    var tasks: Results<Task>! {
        didSet {
            // Whenever notes update, update the table view
            taskListTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        //let realm = Realm()
        super.viewDidLoad()
        taskListTableView.dataSource = self
        taskListTableView.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let realm = Realm()
        //tasks = realm.objects(Task).sorted("modificationDate", ascending: false)
        tasks = realm.objects(Task)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier { let realm = Realm()
            switch identifier {
            case "Save":
                let source = segue.sourceViewController as! NewTaskViewController
                
                realm.write() {
                    realm.add(source.currentTask!) //currentTask
                }
            case "Delete":
                realm.write() {
                    realm.delete(self.selectedTask!)
                }
                
                let source = segue.sourceViewController as! TaskDisplayViewController
                source.task = nil;
                
            default:
                println("No one loves \(identifier)")
            }
            
            //tasks = realm.objects(Task).sorted("endDate", ascending: false)
            tasks = realm.objects(Task)
        }
        
           }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "ShowExistingTask") {
            let taskViewController = segue.destinationViewController as! TaskDisplayViewController
            taskViewController.task = selectedTask
            //taskViewController.title = selectedTask.title
            //taskViewController.endDate = selectedTask.endDate
            //taskViewController.content = selectedTask.content
        }
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

extension taskListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskTableViewCell
        
        let row = indexPath.row
        let task = tasks[row] as Task
        cell.task = task
        
        cell.checked = false
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(tasks?.count ?? 0)
    }
    
}

extension taskListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTask = tasks[indexPath.row]      //1
        
        println(indexPath.row)
        for task in tasks {
            println(task.endDate)
            titleTest =  task.title
               selectedTask = task
        }
        self.performSegueWithIdentifier("ShowExistingTask", sender: self)     //2
    }
    
    // 3
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let task = tasks[indexPath.row] as Object
            
            let realm = Realm()
            
            realm.write() {
                realm.delete(task)
            }
            
            //tasks = realm.objects(Task).sorted("endDate", ascending: false)
            tasks = realm.objects(Task) 
        }
    }
    
}
