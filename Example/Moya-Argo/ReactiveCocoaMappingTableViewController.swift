//
//  ReactiveCocoaMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import ReactiveCocoa
import Moya_Argo

class ReactiveCocoaMappingTableViewController: DemoBaseTableViewController {

    let provider:ReactiveCocoaMoyaProvider<DemoTarget> = ReactiveCocoaMoyaProvider(stubClosure: { _ in return .Immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ReactiveCocoa"
    }

    //MARK: Overrides
    override func fetchUsers() {
        
        provider.request(.AllUsers).mapArray(ArgoUser.self, rootKey: "users").observeOn(UIScheduler()).start { event in

            switch event {
            case .Next(let users):
                self.users = users.map { $0 }
                self.tableView.reloadData()
            case .Failed(let error):
                print("error: \(error)")
            default: break
            }
        }
    }
    
    override func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
        provider.request(.User(userID: user.id.description)).mapObject(ArgoUser).observeOn(UIScheduler()).start { event in
            
            switch event {
            case .Next(let user):
                showAlertClosure(user)
            case .Failed(let error):
                print("error: \(error)")
            default:
                break
            }
        }
        
    }
}
