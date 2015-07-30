//
//  NewTaskViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class NewTaskViewController: UIViewController {

    var currentTask: Task?
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*currentTask = Task()
        currentTask!.title   = "New Task!!!"
        currentTask!.content = "Yet More Content"
        //currentTask!.title = taskName.text
        //currentTask!.endDate = endDate.text
        //currentTask!.content = taskDescription.text*/
        
        if (segue.identifier == "ShowNewTask") {
            // create a new Task and hold onto it, to be able to save it later
            currentTask = Task()
            let taskViewController = segue.destinationViewController as! TaskDisplayViewController
            taskViewController.task = currentTask
            taskViewController.edit = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
