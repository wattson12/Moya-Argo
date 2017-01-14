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
    
    let provider:MoyaProvider<DemoTarget> = MoyaProvider(stubClosure: { _ in .immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Plain Moya"
    }
    
    
    //MARK: Overrides
    override func fetchUsers() {
        
        self.provider.request(.allUsers) { result in
            
            switch result {
            case .success(let response):
                self.processResponse(response)
            case .failure(let error):
                print("failed: \(error)")
            }
        }
    }
    
    fileprivate func processResponse(_ response: Response) {
        
        let JSON = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String: Any]
        
        if let users = JSON["users"] as? [[String:AnyObject]] {
            
            self.users = users.map { (userDictionary:[String:AnyObject]) -> PlainMoyaUser? in
                
                if let userID = userDictionary["id"] as? Int, let userName = userDictionary["name"] as? String {
                    return PlainMoyaUser(id: userID, name: userName, birthdate: nil)
                } else {
                    return nil
                }
            }.flatMap { $0 }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func fetchUserDetail(_ user: UserType, showAlertClosure: @escaping (UserType) -> ()) {
        
        self.provider.request(.user(userID: user.id.description)) { result in
            
            switch result {
            case .success(let response):
                self.processUserDetailResponse(response, showAlertClosure: showAlertClosure)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    fileprivate func processUserDetailResponse(_ response: Response, showAlertClosure: @escaping (UserType) -> ()) {
        
        let JSON = try! JSONSerialization.jsonObject(with: response.data, options: []) as! [String: Any]
        
        if let userID = JSON["id"] as? Int,
           let userName = JSON["name"] as? String,
            let userBirthdate = JSON["birthdate"] as? String {
                
                DispatchQueue.main.async {
                    showAlertClosure(PlainMoyaUser(id: userID, name: userName, birthdate: userBirthdate))
                }
        }

    }

}
