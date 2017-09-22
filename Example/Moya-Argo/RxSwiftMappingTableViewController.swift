//
//  RxSwiftMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 Sam Watts. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Moya_Argo

class RxSwiftMappingTableViewController: DemoBaseTableViewController {

//    let provider:RxMoyaProvider<DemoTarget> = RxMoyaProvider(stubClosure: { _ in return .immediate })
    let provider: MoyaProvider<DemoTarget> = MoyaProvider(stubClosure: { _ in return .immediate })
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift"
    }
    
    //MARK: Overrides
    override func fetchUsers() {
    
        //example using convenience method (original commented out)

        
        provider
            .rx
            .request(.allUsers)
//            .mapArray(ArgoUser.self, rootKey: "users")
            .mapUsers()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:  { users in
            
                self.users = users.map { $0 }
                
                self.tableView.reloadData()
            
            }).addDisposableTo(disposeBag)
        
        // example showing map with type inference (type of users in subscribe next closure required)
//        provider
//            .request(.AllUsers)
//            .mapArray("users")
//            .observeOn(MainScheduler.instance)
//            .subscribeNext { (users:[ArgoUser]) in
//                
//                self.users = users.map { $0 }
//                
//                self.tableView.reloadData()
//                
//            }.addDisposableTo(disposeBag)
    }
    
    override func fetchUserDetail(_ user: UserType, showAlertClosure: @escaping (UserType) -> ()) {
        
        provider
            .rx
            .request(.user(userID: user.id.description))
//            .mapObject(ArgoUser)
            .mapUser()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
                showAlertClosure(user)
            })
            .addDisposableTo(disposeBag)
        
    }

}
