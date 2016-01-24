//
//  DemoBaseTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import UIKit

protocol UserType {
    
    var id: Int { get }
    var name: String { get }
    var birthdate: String? { get }
}

class DemoBaseTableViewController: UITableViewController {
    
    var users:[UserType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "DemoUserCellReuseIdentifier")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchUsers()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DemoUserCellReuseIdentifier", forIndexPath: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alertClosure = { (user:UserType) in
            
            let alertController = UIAlertController(title: "User", message: "ID: \(user.id)\nBirthdate: \(user.birthdate!)", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in alertController.dismissViewControllerAnimated(true, completion: nil) }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        self.fetchUserDetail(users[indexPath.row], showAlertClosure: alertClosure)
    }

    //MARK: methods which subclasses should override

    func fetchUsers() {
        
    }
    
    func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
    }
    
}
