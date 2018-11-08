//
//  ViewController.swift
//  TipCalculator
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Public properties
    
    lazy var totalLabel: UILabel = {
        let l = UILabel(useAutoLayout: true)
        return l
    }()
    
    lazy var tipTitleLable: UILabel = {
        let l = UILabel(useAutoLayout: true)
        return l
    }()
    
    lazy var inputTextField: UITextField = {
        let t = UITextField(useAutoLayout: true)
        t.placeholder = "\(self.payment.pay)"
        t.keyboardType = .numbersAndPunctuation
        return t
    }()
    
    //MARK: UIViewController Life cycle overrides
    override func loadView() {
        guard let frame = (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds else { return }
        let view = UIView(frame: frame, useAutoLayout: true)
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
    }
    //MARK: Private properties
    
    private var payment = Payment<Dollar>(value: 0)
    
    //MARK: Private methods
    private func setupSubViews() {
        
    }
    
}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutoLayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
    }
}
