//
//  ContactDetailsVC.swift
//  exam
//
//  Created by Liu Fan Wei on 7/4/19.
//  Copyright © 2019 Liu Fan Wei. All rights reserved.
//

import UIKit

typealias SaveBlock = (_ model: ContactModel, _ indexPath: IndexPath?) -> Void

enum TextFieldType: Int {
    case firstName, lastName, email, phone
}

class ContactDetailsVC: UIViewController {
    
    var model = ContactModel()
    var saveBlock :SaveBlock?
    var indexPath: IndexPath?
    
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textField in textFields {
            guard let textFieldType = TextFieldType(rawValue: textField.tag) else{
                continue
            }
            switch textFieldType {
            case TextFieldType.firstName:
                textField.text = model.firstName
            case TextFieldType.lastName:
                textField.text = model.lastName
            case TextFieldType.email:
                textField.text = model.email
            case TextFieldType.phone:
                textField.text = model.phone
            }
        }
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        if !isValidateContact() {
            return
        }
        for textField in textFields {
            guard let textFieldType = TextFieldType(rawValue: textField.tag) else{
                continue
            }
            switch textFieldType {
            case TextFieldType.firstName:
                model.firstName = textField.text
            case TextFieldType.lastName:
                model.lastName = textField.text
            case TextFieldType.email:
                model.email = textField.text
            case TextFieldType.phone:
                model.phone = textField.text
            }
        }
        saveBlock?(model, indexPath)
        navigationController?.popViewController(animated: true);
    }
    
    private func isValidateContact() -> Bool {
        
        guard let firstName = textFields[TextFieldType.firstName.rawValue].text, let lastName = textFields[TextFieldType.lastName.rawValue].text, !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            let alert = UIAlertController(title: "First Name/Last Name", message: "First name and Last name is mandatory", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
            return false
        }
        return true
    }
}

extension ContactDetailsVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
