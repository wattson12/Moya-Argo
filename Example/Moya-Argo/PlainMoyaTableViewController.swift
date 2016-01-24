//
//  PlainMoyaTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import UIKit
import Moya

struct PlainMoyaUser {
    
    let id: Int
    let name: String
    let birthdate: String? 
}

extension PlainMoyaUser: UserType { }

class PlainMoyaTableViewController: DemoBaseTableViewController {
    
    let provider:MoyaProvider<DemoTarget> = MoyaProvider(stubClosure: { _ in .Immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Plain Moya"
    }
    
    
    //MARK: Overrides
    override func fetchUsers() {
        
        self.provider.request(.AllUsers) { result in
            
            switch result {
            case .Success(let response):
                self.processResponse(response)
            case .Failure(let error):
                print("failed: \(error)")
            }
        }
    }
    
    private func processResponse(response: Response) {
        
        let JSON = try! NSJSONSerialization.JSONObjectWithData(response.data, options: [])
        
        if let users = JSON["users"] as? [[String:AnyObject]] {
            
            self.users = users.map { (userDictionary:[String:AnyObject]) -> PlainMoyaUser? in
                
                if let userID = userDictionary["id"] as? Int, let userName = userDictionary["name"] as? String {
                    return PlainMoyaUser(id: userID, name: userName, birthdate: nil)
                } else {
                    return nil
                }
            }.flatMap { $0 }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
        self.provider.request(.User(userID: user.id.description)) { result in
            
            switch result {
            case .Success(let response):
                self.processUserDetailResponse(response, showAlertClosure: showAlertClosure)
            case .Failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func processUserDetailResponse(response: Response, showAlertClosure: (UserType) -> ()) {
        
        let JSON = try! NSJSONSerialization.JSONObjectWithData(response.data, options: []) as! [String:AnyObject]
        
        if let userID = JSON["id"] as? Int,
           let userName = JSON["name"] as? String,
            let userBirthdate = JSON["birthdate"] as? String {
                
                dispatch_async(dispatch_get_main_queue()) {
                    showAlertClosure(PlainMoyaUser(id: userID, name: userName, birthdate: userBirthdate))
                }
        }

    }

}
