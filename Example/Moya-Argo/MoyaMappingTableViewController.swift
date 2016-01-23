//
//  MoyaMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import Moya_Argo

class MoyaMappingTableViewController: DemoBaseTableViewController {

    let provider:MoyaProvider<DemoTarget> = MoyaProvider(stubClosure: { _ in .Immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Moya Mapping"
    }

    
    //MARK: Overrides
    override func fetchUsers() {
        
        self.provider.request(.AllUsers) { result in
            
            if case let .Success(response) = result {
                
                do {
                    let argoUsers:[ArgoUser] = try response.mapArrayWithRootKey("users")
                    self.users = argoUsers.map { $0 }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print("error in mapping object: \(error)")
                }
                
            }
        }
    }
    
    override func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
        self.provider.request(.User(userID: user.id.description)) { result in
            
            if case let .Success(response) = result {
                
                do {
                    
                    let user:ArgoUser = try response.mapObject()
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        showAlertClosure(user)
                    }
                    
                } catch {
                    print("error in mapping object: \(error)")
                }
                
            }
        }
    }

}
