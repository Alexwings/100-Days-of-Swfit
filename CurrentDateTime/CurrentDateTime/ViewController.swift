//
//  ViewController.swift
//  CurrentDateTime
//
//  Created by Xinyuan Wang on 11/9/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Public propeties
    
    lazy var currentTimeDisplayLabel: UILabel = {
        let l = UILabel(useAutoLayout: true)
        l.font = UIFont.systemFont(ofSize: 30.0, weight: .light)
        let dateString = dateFormatter.string(from: Date())
        l.text = dateString
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    
    //MARK: Private properties
    private lazy var dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.timeZone = TimeZone.current
        fmt.dateStyle = .medium
        fmt.timeStyle = .medium
        return fmt
    }()
    
    //MARK: ViewController Life Cycle
    override func loadView() {
        let view = UIView(frame: (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds ?? .zero)
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: Action methods
    
    @objc func refreshButtonClicked(_ sender: UIButton) {
        currentTimeDisplayLabel.text = dateFormatter.string(from: Date())
    }
    
    //MARK: Private methods
    private func setupSubViews() {
        let layout = self.view.safeAreaLayoutGuide
        let titleLabel = UILabel(useAutoLayout: true)
        titleLabel.textAlignment = .center
        titleLabel.text = "Current Date and Time"
        
        let refreshBtn = UIButton(useAutoLayout: true)
        refreshBtn.setTitle("Refresh", for: .normal)
        refreshBtn.setTitleColor(.blue, for: .normal)
        refreshBtn.setTitleColor(.white, for: .highlighted)
        refreshBtn.addTarget(self, action: #selector(refreshButtonClicked(_:)), for: .touchUpInside)
        
        self.view.addSubview(currentTimeDisplayLabel)
        currentTimeDisplayLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        currentTimeDisplayLabel.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        currentTimeDisplayLabel.sizeToFit()
        self.view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: currentTimeDisplayLabel.topAnchor, constant: -10).isActive = true
        titleLabel.sizeToFit()
        
        self.view.addSubview(refreshBtn)
        refreshBtn.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        refreshBtn.topAnchor.constraint(equalTo: currentTimeDisplayLabel.bottomAnchor, constant: 10).isActive = true
        refreshBtn.sizeToFit()
    }
}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutoLayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
    }
}
