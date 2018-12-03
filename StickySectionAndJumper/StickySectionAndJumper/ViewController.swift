//
//  ViewController.swift
//  StickySectionAndJumper
//
//  Created by Xinyuan Wang on 11/17/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Private properties
    
    private let cellId = "tableCell"
    
    private var dataSource: [String: [String]] = [:] {
        didSet {
            self.keys = dataSource.keys.sorted()
        }
    }
    //Do not directly set this property, it's used for tracking the keys of the datasource
    private var keys: [String] = []
    //MARK: life cycle override
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.keys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = self.dataSource[keys[section]] else { return 0 }
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let array = dataSource[keys[indexPath.section]] {
            cell.textLabel?.text = array[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
}
