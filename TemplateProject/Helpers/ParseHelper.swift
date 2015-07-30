//
//  ParseHelper.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/24/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    //Task relation - completed (bool), endDate (String), taskname (string)
    //Group relation - users (array), tasks (array), groupname (string)
    //User (member) relation - username (string), groups (array), myTasks (array)
    
    //Parse methods needed:
    //add a task, add a group, delete a task, delete a group, returning an array of users/members of a group, returning an array of the all the groups a user has, returning all the tasks of a user/member in a group, returning an array of all of one user's tasks
    
    static func addTaskToUserInGroup(user: PFUser, group: Group) {
        let taskObject = PFObject(className: "Task")
        taskObject["user"] = user
        taskObject["group"] = group
        
        
        /*let groupQuery = PFQuery(className: "Group")
        let groupObject = PFObject(className: "Group")
        groupQuery.whereKey("user", equalTo: user)*/
        
        taskObject.saveInBackgroundWithBlock(nil)
    }
    
    static func deleteTask(user: PFUser, group: Group) {
        
    }
    
   
}
