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
    
    case PlainMoya
    case MoyaWithMapping
    case MoyaWithReactiveCocoa
    case MoyaWithRxSwift
    
    var reuseIdentifier: String {
        return "ExampleRowReuseIdentifier"
    }
    
    var viewControllerForExample: UIViewController {
        
        switch self {
        case .PlainMoya:
            return PlainMoyaTableViewController()
        default: break
        }
        
        return UIViewController()
    }
    
    var exampleDescription: String {
        
        switch self {
        case .PlainMoya: return "Plain Moya"
        default: return "not implemented"
        }
    }
}

class ViewController: UIViewController {
    
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRectZero, style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier:  ExampleRow.PlainMoya.reuseIdentifier)
        
        self.view.addSubview(self.tableView)
        
        constrain(self.tableView, self.view) { table, view in
            table.edges == view.edges
        }
        
        self.title = "Moya + Argo"
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let row = ExampleRow(rawValue: indexPath.row) else { fatalError("something bad has happened") }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(row.reuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = row.exampleDescription
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        guard let row = ExampleRow(rawValue: indexPath.row) else { fatalError("something bad has happened") }

        let viewController = row.viewControllerForExample
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

