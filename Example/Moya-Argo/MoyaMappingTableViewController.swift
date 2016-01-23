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
                    let argoUsers:[ArgoUser] = try response.mapArray()
                    
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

}
