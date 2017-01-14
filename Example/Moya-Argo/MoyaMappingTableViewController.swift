//
//  MoyaMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import UIKit
import Moya
import Moya_Argo

class MoyaMappingTableViewController: DemoBaseTableViewController {

    let provider:MoyaProvider<DemoTarget> = MoyaProvider(stubClosure: { _ in .immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Moya Mapping"
    }

    
    //MARK: Overrides
    override func fetchUsers() {
        
        self.provider.request(.allUsers) { result in
            
            if case let .success(response) = result {
                
                do {
                    
//                    let argoUsers:[ArgoUser] = try response.mapArrayWithRootKey("users")
                    let argoUsers = try response.mapUsers() //cleaner with extension helper
                    
                    self.users = argoUsers.map { $0 }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("error in mapping object: \(error)")
                }
                
            }
        }
    }
    
    override func fetchUserDetail(_ user: UserType, showAlertClosure: @escaping (UserType) -> ()) {
        
        self.provider.request(.user(userID: user.id.description)) { result in
            
            if case let .success(response) = result {
                
                do {
                    
//                    let user:ArgoUser = try response.mapObject()
                    let user = try response.mapUser()
                    
                    DispatchQueue.main.async {
                        showAlertClosure(user)
                    }
                    
                } catch {
                    print("error in mapping object: \(error)")
                }
                
            }
        }
    }

}
