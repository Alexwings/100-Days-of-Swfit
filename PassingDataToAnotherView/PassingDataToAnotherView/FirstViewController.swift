//
//  ViewController.swift
//  PassingDateToAnotherView
//
//  Created by Xinyuan Wang on 11/9/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: Public properties
    @IBOutlet weak var inputTextField: UITextField!
    
    //MARK: system lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputTextField.text = ""
        inputTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond",
            let input = sender as? UITextField,
            let des = segue.destination as? SecondViewController {
            let text = input.text
            des.configure(with: text)
            input.resignFirstResponder()
        }
    }
    
    //MARK: action methods
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSecond", sender: self.inputTextField)
    }
}
