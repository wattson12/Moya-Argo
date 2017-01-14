//
//  ReactiveCocoaMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import UIKit
import Moya
import ReactiveSwift
import Moya_Argo

class ReactiveCocoaMappingTableViewController: DemoBaseTableViewController {

    let provider:ReactiveSwiftMoyaProvider<DemoTarget> = ReactiveSwiftMoyaProvider(stubClosure: { _ in return .immediate })

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ReactiveCocoa"
    }

    //MARK: Overrides
    override func fetchUsers() {
        
        provider
            .request(.allUsers)
//            .mapArray(ArgoUser.self, rootKey: "users")
            .mapUsers()
            .observe(on: UIScheduler())
            .start { event in

            switch event {
            case .value(let users):
                self.users = users.map { $0 }
                self.tableView.reloadData()
            case .failed(let error):
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
    
    override func fetchUserDetail(_ user: UserType, showAlertClosure: @escaping (UserType) -> ()) {
        
        provider
            .request(.user(userID: user.id.description))
//            .mapObject(ArgoUser)
            .mapUser()
            .observe(on: UIScheduler())
            .start { event in
            
            switch event {
            case .value(let user):
                showAlertClosure(user)
            case .failed(let error):
                print("error: \(error)")
            default:
                break
            }
        }
        
    }
}
