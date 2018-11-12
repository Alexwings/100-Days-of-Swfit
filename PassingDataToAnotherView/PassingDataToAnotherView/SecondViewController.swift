//
//  SecondViewController.swift
//  PassingDateToAnotherView
//
//  Created by Xinyuan Wang on 11/9/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    //MARK: public properties
    @IBOutlet weak var infoDisplayLabel: UILabel!
    private(set) var message: String = ""
    //MARK: system life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        infoDisplayLabel.text = message
    }
    //MARK: public methods
    func configure(with content: String?) {
        guard let content = content else { return }
        message = content
    }
}
