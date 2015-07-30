//
//  Task.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var endDate: String = ""
    //dynamic var done: Bool = isChecked!
}
