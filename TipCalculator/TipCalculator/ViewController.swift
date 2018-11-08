//
//  ViewController.swift
//  TipCalculator
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: class config struct
    struct Config {
        static let inputSize: CGFloat = 100
        static let resultLabelSize: CGFloat = 20
        static let resultPaddingSize: CGFloat = 30
        static let padding: CGFloat = 50
        static let edgeSpacing: CGFloat = 10
    }
    
    //MARK: Public properties
    lazy var totalLabel: UILabel = {
        let l = UILabel(useAutoLayout: true)
        l.font = UIFont.systemFont(ofSize: Config.resultLabelSize)
        l.text = "\(self.payment.totalPay)"
        return l
    }()
    
    lazy var tipTitleLable: UILabel = {
        let l = UILabel(useAutoLayout: true)
        l.textAlignment = .left
        l.text = "Tip(\(Int(self.payment.tipRate * 100))%):"
        l.font = UIFont.systemFont(ofSize: Config.resultLabelSize)
        return l
    }()
    
    lazy var tipLabel: UILabel = {
        let l = UILabel(useAutoLayout: true)
        l.textAlignment = .right
        l.text = "\(self.payment.tip)"
        l.font = UIFont.systemFont(ofSize: Config.resultLabelSize)
        return l
    }()
    
    lazy var inputTextField: UITextField = {
        let t = UITextField(useAutoLayout: true)
        t.placeholder = "\(self.payment.pay)"
        t.keyboardType = UIKeyboardType.decimalPad
        t.textAlignment = .right
        t.font = UIFont.systemFont(ofSize: Config.inputSize)
        t.delegate = self
        return t
    }()
    
    lazy var percentageSlider: UISlider = {
        let slider = UISlider(useAutoLayout: true)
        slider.maximumValue = 1.0
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.setValue(self.payment.tipRate, animated: false)
        return slider
    }()
    
    //MARK: UIViewController Life cycle overrides
    override func loadView() {
        guard let frame = (UIApplication.shared.delegate as? AppDelegate)?.window?.bounds else { return }
        let view = UIView(frame: frame, useAutoLayout: false)
        view.backgroundColor = .white
        self.view = view
        setupSubViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        self.percentageSlider.addTarget(self, action: #selector(tipPercentChanged(_:)), for: .valueChanged)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didFinishEnterInitialPayment(_:)))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBar = UIToolbar()
        toolBar.items = [flexible, doneButton]
        toolBar.sizeToFit()
        inputTextField.inputAccessoryView = toolBar
    }
    
    //MARK: Action methods
    @objc func tipPercentChanged(_ slider: UISlider) {
        if !self.payment.update(rate: slider.value) {
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let alert = UIAlertController(title: "In Valid Tip Rate", message: "The tip rate you entered is not valid, please choose a value between 0 - 1", preferredStyle: .alert)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func didFinishEnterInitialPayment(_ button: UIButton) {
        self.inputTextField.resignFirstResponder()
    }
    
    //MARK: Private properties
    
    private var payment = Payment<Dollar>(value: 0) {
        didSet {
            tipTitleLable.text = "Tip(\(Int(self.payment.tipRate * 100))%):"
            tipLabel.text = "\(self.payment.tip)"
            totalLabel.text = "\(self.payment.totalPay)"
        }
    }
    
    //MARK: Private methods
    private func setupSubViews() {
        let layout = self.view.safeAreaLayoutGuide
        self.view.addSubview(inputTextField)
        inputTextField.topAnchor.constraint(equalTo: layout.topAnchor, constant: Config.padding).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: 0 - Config.edgeSpacing).isActive = true
        inputTextField.leadingAnchor.constraint(lessThanOrEqualTo: layout.leadingAnchor).isActive = true
        
        self.view.addSubview(tipLabel)
        tipLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: Config.resultPaddingSize).isActive = true
        tipLabel.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: 0 - Config.edgeSpacing).isActive = true
        tipLabel.sizeToFit()
        
        self.view.addSubview(tipTitleLable)
        tipTitleLable.topAnchor.constraint(equalTo: tipLabel.topAnchor).isActive = true
        tipTitleLable.trailingAnchor.constraint(equalTo: tipLabel.leadingAnchor, constant: 0 - Config.padding).isActive = true
        tipTitleLable.sizeToFit()
        
        self.view.addSubview(totalLabel)
        totalLabel.trailingAnchor.constraint(equalTo: tipLabel.trailingAnchor).isActive = true
        totalLabel.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: Config.resultPaddingSize).isActive = true
        totalLabel.sizeToFit()
        
        let label = UILabel(useAutoLayout: true)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: Config.resultLabelSize)
        label.text = "Total:"
        self.view.addSubview(label)
        label.topAnchor.constraint(equalTo: totalLabel.topAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: tipTitleLable.trailingAnchor).isActive = true
        label.sizeToFit()
        
        self.view.addSubview(percentageSlider)
        percentageSlider.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: Config.resultPaddingSize).isActive = true
        percentageSlider.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: Config.edgeSpacing).isActive = true
        percentageSlider.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: 0 - Config.edgeSpacing).isActive = true
        
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if !text.isEmpty, let value = Float(text), let pay = Payment<Dollar>(value: value, rate: self.payment.tipRate) {
            self.payment = pay
        }
        textField.text = "\(self.payment.pay)"
    }
}

extension UIView {
    convenience init(frame: CGRect = .zero, useAutoLayout: Bool) {
        self.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = !useAutoLayout
    }
}
