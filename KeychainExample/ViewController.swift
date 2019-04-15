//
//  ViewController.swift
//  KeychainExample
//
//  Created by Yiyin Shen on 15/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberkeyTextField: UITextField!
    @IBOutlet weak var didTapSaveNumber: UIButton!

    @IBOutlet weak var stringTextField: UITextField!
    @IBOutlet weak var stringKeyTextField: UITextField!

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userKeyTextField: UITextField!

    @IBOutlet weak var keyTextField: UITextField!

    @IBAction func didTapSaveString(_ sender: Any) {
        if let string = stringTextField.text, string != "",
            let key = stringKeyTextField.text, key != "" {
            if KeychainManager.saveData(data: string, withIdentifier: key) {
                print("String saved successfully")
            } else {
                print("Failed to save String")
            }
        }
    }
    @IBAction func didTapSaveNumber(_ sender: Any) {
        if let number = numberTextField.text, number != "",
            let key = numberkeyTextField.text, key != "" {
            if KeychainManager.saveData(data: number, withIdentifier: key) {
                print("Number saved successfully")
            } else {
                print("Failed to save number")
            }
        }

    }

    @IBAction func didTapSaveUser(_ sender: Any) {
        if let userId = userIdTextField.text, userId != "",
            let userName = userNameTextField.text, userName != "",
            let key = userKeyTextField.text, key != "" {
            
            let user = User()
            user.userId = userId
            user.userName = userName
            if KeychainManager.saveObject(object: user, withIdentifier: key) {
                print("Saved User successully")
            } else {
                print("Failed to save User")
            }
        }
    }


    @IBAction func didTapFetchNumber(_ sender: Any) {
        guard let key = keyTextField.text else { return }
        if let fetchedData = KeychainManager.readData(identifier: key) {
            print("fetched number: \(fetchedData )")
        } else {
            print("Number not found")
        }
    }
    
    @IBAction func didTapFetchString(_ sender: Any) {
        guard let key = keyTextField.text else { return }
        if let fetchedData = KeychainManager.readData(identifier: key) {
            print("fetched string: \(fetchedData)")
        } else {
            print("String not found")
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        guard let key = keyTextField.text else { return }
        if KeychainManager.deleteData(for: key) {
            print("Deleted \(key)")
        } else {
            print("Failed to delete")
        }
    }
    
    @IBAction func didTapFetchUser(_ sender: Any) {
        guard let key = keyTextField.text else { return }
        let fetchedObject: User? = KeychainManager.readObject(identifier: key)
        if let user = fetchedObject {
            print("fetched User: \(user.userId ?? "")  \(user.userName ?? "")")
        } else {
            print("User not found")
        }
    }
}
