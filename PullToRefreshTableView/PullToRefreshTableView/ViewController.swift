//
//  ViewController.swift
//  PullToRefreshTableView
//
//  Created by Xinyuan Wang on 11/13/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Views
    lazy var tableView: UITableView = {
        let tableView = UITableView(useAutolayout: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        return tableView
    }()
    
    //MARK: public properties
    
    //MARK: public APIs
    
    //MARK: view controller life cycle
    override func loadView() {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Groceries"
        let editBtn = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonClicked(_:)))
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked(_:)))
        self.navigationItem.leftBarButtonItem = editBtn
        self.navigationItem.rightBarButtonItem = addBtn
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellId)
        tableView.refreshControl?.addTarget(self, action: #selector(handleTableViewRefresh(_:)), for: .valueChanged)
    }

    //MARK: action methods
    @objc func editButtonClicked(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing {
            sender.title = "Edit"
            self.tableView.setEditing(false, animated: true)
        }else {
            self.tableView.setEditing(true, animated: true)
            sender.title = "Done"
        }
    }
    
    @objc func addButtonClicked(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing {
            self.editButtonClicked(self.navigationItem.leftBarButtonItem!)
        }
        let alert = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.borderStyle = .roundedRect
            textField.autocapitalizationType = .words
        }

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let self = self else { return }
            guard let text = alert.textFields?.first?.text else { return }
            self.dataSource.append(text)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleTableViewRefresh(_ sender: UIRefreshControl) {
        self.dataSource = self.replacement
        self.tableView.reloadData()
        sender.endRefreshing()
    }
    
    //MARK: private properties
    private var dataSource: [String] = ["Fish", "Carrots","Apple", "Peach", "Beef", "Smart Water", "Chinese Cabbage", "Bamboo root"]
    private var replacement: [String] = ["Milk", "Ham", "Chicken Breast", "Eggs"]
    private let cellId = "CellId"
    //MARK: private methods
    private func setupSubViews() {
        let layout = self.view.safeAreaLayoutGuide
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: layout.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layout.trailingAnchor).isActive = true
        
        tableView.tableFooterView = UIView(useAutolayout: false)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dataSource.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutolayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutolayout
    }
}
