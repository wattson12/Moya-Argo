//
//  ViewController.swift
//  Moya-Argo
//
//  Created by Sam Watts on 01/23/2016.
//  Copyright (c) 2016 Sam Watts. All rights reserved.
//

import UIKit
import Cartography

enum ExampleRow: Int {
    
    case plainMoya
    case moyaWithMapping
    case moyaWithReactiveCocoa
    case moyaWithRxSwift
    
    var reuseIdentifier: String {
        return "ExampleRowReuseIdentifier"
    }
    
    var viewControllerForExample: UIViewController {
        
        switch self {
        case .plainMoya:
            return PlainMoyaTableViewController()
        case .moyaWithMapping:
            return MoyaMappingTableViewController()
        case .moyaWithReactiveCocoa:
            return ReactiveCocoaMappingTableViewController()
        case .moyaWithRxSwift:
            return RxSwiftMappingTableViewController()
        }
    }
    
    var exampleDescription: String {
        
        switch self {
        case .plainMoya:
            return "Plain Moya"
        case .moyaWithMapping:
            return "Moya with mapping"
        case .moyaWithReactiveCocoa:
            return "Moya with ReactiveCocoa"
        case .moyaWithRxSwift:
            return "Moya with RxSwift"
        }
    }
}

class ViewController: UIViewController {
    
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:  ExampleRow.plainMoya.reuseIdentifier)
        
        self.view.addSubview(self.tableView)
        
        constrain(self.tableView, self.view) { table, view in
            table.edges == view.edges
        }
        
        self.title = "Moya + Argo"
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = ExampleRow(rawValue: indexPath.row) else { fatalError("something bad has happened") }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = row.exampleDescription
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = ExampleRow(rawValue: indexPath.row) else { fatalError("something bad has happened") }

        let viewController = row.viewControllerForExample
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

