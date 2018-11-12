//
//  KeyboardHandler.swift
//  SwipeDismissKeyboard
//
//  Created by Xinyuan Wang on 11/12/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import Foundation
import UIKit

class KeyboardHandler: NSObject {
    //MARK: Public properties
    private(set) var currentText: String = ""
    @objc dynamic private(set) var currentKeyboardHeight: CGFloat = 0
    //MARK: Private Properties
    private weak var currentTextView: UITextView?
    //MARK: init methods
    required init(textView: UITextView) {
        super.init()
        currentTextView = textView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: action handler
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.currentKeyboardHeight = keyboardFrame.size.height
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.currentKeyboardHeight = 0
    }
    //MARK: Public APIs
    func dismissKeyboard(clearText: Bool=false) {
        self.currentTextView?.endEditing(true)
        guard clearText else { return }
        self.currentTextView?.text = ""
    }
}


