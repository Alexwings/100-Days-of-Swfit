//
//  ViewController.swift
//  TapOrHoldCounter
//
//  Created by Xinyuan Wang on 11/7/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapOrHoldBtn: UIButton!
    @IBOutlet weak var displayLabel: UILabel!
    
    private var counter: Counter = Counter(value: 0) {
        didSet {
            self.displayLabel.text = "\(counter)"
        }
    }
    
    lazy var longPressGuesture: UILongPressGestureRecognizer = {
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longPressedHappened(_:)))
        long.minimumPressDuration = 0.5
        return long
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(longPressGuesture)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        self.counter.value = 0
    }
    
    @IBAction func didClickCounterButton(_ sender: UIButton) {
        self.counter.value += 1
        if !self.longPressGuesture.isEnabled {
            self.longPressGuesture.isEnabled = true
            sender.removeTarget(self, action: #selector(didHoldOnCounterButton(_:)), for: .touchDragInside)
        }
    }
    
    @objc func didHoldOnCounterButton(_ sender: UIButton) {
        self.counter.value += 1
    }
    
    @objc func longPressedHappened(_ guesture: UILongPressGestureRecognizer) {
        let loc = guesture.location(in: self.tapOrHoldBtn)
        guard loc.x >= 0 && loc.x <= self.tapOrHoldBtn.bounds.maxX && loc.y >= 0 && loc.y <= self.tapOrHoldBtn.bounds.maxY else { return }
        self.tapOrHoldBtn.addTarget(self, action: #selector(didHoldOnCounterButton(_:)), for: .touchDragInside)
        guesture.isEnabled = false
    }
}

