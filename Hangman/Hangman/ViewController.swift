//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let model = HangmanBrain()
    
    @IBOutlet weak var enterWordTextField: UITextField!
    @IBOutlet weak var whichPlayerSelected: UISegmentedControl!
    @IBOutlet weak var selectThePlayerLabel: UILabel!
    @IBAction func playerToggle(_ sender: UISegmentedControl) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterWordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        model.wordToUnderScores(enteredWord: text)
        
        let alert =  UIAlertController(title: "Word Enterd!", message: "You've enterd the word \"\(playerSelectedWord)\". Confirm?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: {(UIAlertAction) in
            self.performSegue(withIdentifier: "goToSecondScreen", sender: self)})
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else {
            return true
        }
        guard string.characters.count == 1 else {
            return false
        }
        guard CharacterSet.letters.contains(UnicodeScalar(string)!) else {
            return false
        }
        return true
    }
    
}

