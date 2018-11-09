//
//  ViewController.swift
//  BasicTableView
//
//  Created by Xinyuan Wang on 11/9/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //MARK: Private properties
    private var dataSource: [String] = [] {
        didSet {
            guard !self.tableView.isEditing else { return }
            self.tableView.reloadData()
        }
    }
    private let cellId: String = "MovieTitleCell"
    
    //MARK: System Life cycle overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        load(datasource: &dataSource)
    }
    
    //MARK: action methods
    @IBAction func editButtonClicked(_ sender: UIBarButtonItem) {
        if !self.tableView.isEditing {
            sender.title = "Done"
            self.tableView.setEditing(true, animated: true)
        }else {
            sender.title = "Edit"
            self.tableView.setEditing(false, animated: true)
        }
    }
    
    private func load(datasource: inout [String]) {
        guard let path = Bundle.main.path(forResource: "Movies", ofType: "plist") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let content = try PropertyListDecoder().decode([String].self, from: data)
            datasource = content
        }catch let error {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        dataSource.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
        tableView.reloadData()
    }
}
