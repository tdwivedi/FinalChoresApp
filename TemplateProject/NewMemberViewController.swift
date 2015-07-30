//
//  NewMemberViewController.swift
//  TemplateProject
//
//  Created by Trisha Dwivedi on 7/30/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class NewMemberViewController: UIViewController {

    
    @IBOutlet weak var newMemberNameLabel: UITextField!
    
    var currentMember: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
