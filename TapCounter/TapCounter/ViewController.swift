//
//  ViewController.swift
//  TapCounter
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Public properties
    
    lazy var displayLabel: UILabel = {
        let label = UILabel(useAutoLayout: true)
        label.font = UIFont.systemFont(ofSize: 100)
        label.text = "\(self.counter)"
        return label
    }()
    
    lazy var tapButton: UIButton = {
        let btn = UIButton(useAutoLayout: true)
        let normalAttributedTitle = NSAttributedString(string: "Tap", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
                                                                             NSAttributedString.Key.foregroundColor: UIColor.blue])
        btn.setAttributedTitle(normalAttributedTitle, for: .normal)
        let highLightedAttributedTitle = NSAttributedString(string: "Tap", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30),
                                                                                   NSAttributedString.Key.foregroundColor: UIColor.white])
        btn.setAttributedTitle(highLightedAttributedTitle, for: .highlighted)
        btn.addTarget(self, action: #selector(counterButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    //MARK: Private properties
    
    private var counter = Counter(value: 0) {
        didSet {
            self.displayLabel.text = "\(self.counter)"
        }
    }
    
    //MARK: UIViewController LifeCycle overrides
    override func loadView() {
        guard var windowFrame = (UIApplication.shared.delegate as! AppDelegate).window?.bounds else {
            fatalError("AppDelegate's window did not set")
        }
        
        if let nav = self.navigationController {
            windowFrame = CGRect(x: windowFrame.origin.x, y: windowFrame.origin.y + nav.navigationBar.frame.height, width: windowFrame.width, height: windowFrame.height - nav.navigationBar.frame.height)
        }
        let view = UIView(frame: windowFrame)
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Counter"
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetButtonClicked(_:)))
        self.navigationItem.leftBarButtonItem = resetButton
    }

    //MARK: action methods
    @objc func resetButtonClicked(_ sender: UIBarButtonItem) {
        self.counter.value = 0
    }
    
    @objc func counterButtonClicked(_ sender: UIButton) {
        self.counter.value += 1
    }
    
    //MARK: private methods
    func setupSubViews() {
        let layoutGuide = self.view.safeAreaLayoutGuide
        self.view.addSubview(self.displayLabel)
        displayLabel.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
        displayLabel.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: -50) .isActive = true
        displayLabel.sizeToFit()
        self.view.addSubview(tapButton)
        tapButton.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: 50).isActive = true
        tapButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor).isActive = true
//        tapButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }

}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutoLayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
    }
}

