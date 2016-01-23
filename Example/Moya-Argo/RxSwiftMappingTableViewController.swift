//
//  RxSwiftMappingTableViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 23/01/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Moya_Argo

class RxSwiftMappingTableViewController: DemoBaseTableViewController {

    let provider:RxMoyaProvider<DemoTarget> = RxMoyaProvider(stubClosure: { _ in return .Immediate })
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift"
    }
    
    //MARK: Overrides
    override func fetchUsers() {
    
        provider
            .request(.AllUsers)
            .mapArray(ArgoUser.self, rootKey: "users")
            .observeOn(MainScheduler.instance)
            .subscribeNext { users in
            
            self.users = users.map { $0 }
            
            self.tableView.reloadData()
            
        }.addDisposableTo(disposeBag)
    }
    
    override func fetchUserDetail(user: UserType, showAlertClosure: (UserType) -> ()) {
        
        provider
            .request(.User(userID: user.id.description))
            .mapObject(ArgoUser)
            .observeOn(MainScheduler.instance)
            .subscribeNext { user in
            
            showAlertClosure(user)
            
        }.addDisposableTo(disposeBag)
        
    }

}
