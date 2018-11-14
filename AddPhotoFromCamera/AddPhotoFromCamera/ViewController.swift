//
//  ViewController.swift
//  AddPhotoFromCamera
//
//  Created by Xinyuan Wang on 11/12/18.
//  Copyright © 2018 Xinyuan Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        let flexiableBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClicked(_:)))
        let clearBtn = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearButtonClicked(_:)))
        let toolBar = UIToolbar()
        toolBar.items = [clearBtn, flexiableBtn, doneBtn]
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }

    @IBAction func cameraButtonClicked(_ sender: UIBarButtonItem) {
        if textView.isFirstResponder {
            textView.endEditing(true)
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Source Type", message: "Please choose your source type.", preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Photo Library", style: .default) { [unowned self] (action) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(actionPhoto)
        self.modalPresentationStyle = .formSheet
        present(actionSheet, animated: true, completion: nil)
    }
    @objc func doneButtonClicked(_ sender: UIBarButtonItem) {
        self.textView.endEditing(true)
    }
    @objc func clearButtonClicked(_ sender: UIBarButtonItem) {
        self.textView.text = ""
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        var newImage: UIImage?
        if let img = info[.originalImage] as? UIImage {
            newImage = img
        }
        if let editedImage = info[.editedImage] as? UIImage {
            newImage = editedImage
        }
        picker.dismiss(animated: true) {[weak self] in
            guard let self = self else { return }
            self.imageView.image = newImage
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

