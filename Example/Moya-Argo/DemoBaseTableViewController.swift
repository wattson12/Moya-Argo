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
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "DemoUserCellReuseIdentifier")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchUsers()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoUserCellReuseIdentifier", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertClosure = { (user:UserType) in
            
            let alertController = UIAlertController(title: "User", message: "ID: \(user.id)\nBirthdate: \(user.birthdate!)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in alertController.dismiss(animated: true, completion: nil) }))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        self.fetchUserDetail(users[indexPath.row], showAlertClosure: alertClosure)
    }

    //MARK: methods which subclasses should override

    func fetchUsers() {
        
    }
    
    func fetchUserDetail(_ user: UserType, showAlertClosure:  @escaping (UserType) -> ()) {
        
    }
    
}
