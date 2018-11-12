//
//  ViewController.swift
//  SwipeDismissKeyboard
//
//  Created by Xinyuan Wang on 11/12/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: views
    lazy var textView: UITextView = {
        let text = UITextView(useAutolayout: true)
        text.font = UIFont.systemFont(ofSize: 30, weight: .light)
        text.delegate = self
        return text
    }()
    
    //MARK: private properties
    private lazy var textViewHandler: KeyboardHandler = {
        let handler = KeyboardHandler(textView: self.textView)
        return handler
    }()
    
    private var observations: [NSKeyValueObservation] = []
    private var textBottomConstraint: NSLayoutConstraint?
    private lazy var swipeGuesture: UISwipeGestureRecognizer = {
        let guesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGuestureAppeared(_:)))
        self.view.addGestureRecognizer(guesture)
        guesture.isEnabled = true
        guesture.direction = .down
        return guesture
    }()
    
    //MARK: ViewController Life cycle
    
    override func loadView() {
        let view = UIView(frame: (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds ?? .zero)
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let observation = textViewHandler.observe(\KeyboardHandler.currentKeyboardHeight, options: [.new]) { [unowned self](_, change) in
            guard let newValue = change.newValue else { return }
            self.textBottomConstraint?.constant = 0 - newValue
            self.textView.setNeedsLayout()
        }
        observations.append(observation)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        observations.removeAll()
    }
    
    //MARK: action methods
    @objc func swipeGuestureAppeared(_ guesture: UISwipeGestureRecognizer) {
        let loc = guesture.location(in: self.view)
        guard loc.y <= self.view.bounds.height - textViewHandler.currentKeyboardHeight else  { return }
        self.textViewHandler.dismissKeyboard()
        guesture.isEnabled = false
    }
    
    @objc func doneButtonDidClicked(_ button: UIBarButtonItem) {
        self.textViewHandler.dismissKeyboard()
        self.swipeGuesture.isEnabled = false
    }
    
    //MARK: Private methods
    func setupSubViews() {
        let layout = self.view.safeAreaLayoutGuide
        self.view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: layout.topAnchor, constant: 16).isActive = true
        self.textBottomConstraint = textView.bottomAnchor.constraint(equalTo: layout.bottomAnchor)
        self.textBottomConstraint?.isActive = true
        textView.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -16).isActive = true
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonDidClicked(_:)))
        self.navigationItem.rightBarButtonItem = btn
    }
}
extension ViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.swipeGuesture.isEnabled = true
        return true
    }
}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutolayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutolayout
    }
}
