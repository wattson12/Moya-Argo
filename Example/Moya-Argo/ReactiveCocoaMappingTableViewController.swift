//
//  ReactiveCocoaMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
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
        
        provider
            .request(.AllUsers)
//            .mapArray(ArgoUser.self, rootKey: "users")
            .mapUsers()
            .observeOn(UIScheduler())
            .start { event in

            switch event {
            case .Next(let users):
                self.users = users.map { $0 }
                self.tableView.reloadData()
            case .Failed(let error):
                print("error: \(error)")
            default: break
            }
        }
        
//        //example of using map method without passing in type as argument
//        provider
//            .request(.AllUsers)
//            .mapArray("users")
//            .observeOn(UIScheduler())
//            .start { (event:Event<[ArgoUser], Moya.Error>) in //type needs to be specified here
//                
//                switch event {
//                case .Next(let users):
//                    self.users = users.map { $0 }
//                    self.tableView.reloadData()
//                case .Failed(let error):
//                    print("error: \(error)")
//                default: break
//                }
//        }
    }
    
    override func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
        provider
            .request(.User(userID: user.id.description))
//            .mapObject(ArgoUser)
            .mapUser()
            .observeOn(UIScheduler())
            .start { event in
            
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
