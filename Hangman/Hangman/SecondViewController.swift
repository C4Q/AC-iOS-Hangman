//
//  SecondViewController.swift
//  Hangman
//
//  Created by C4Q on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//
import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gameTextLabel: UILabel!
    @IBOutlet weak var enterCharTextField: UITextField!
    
    let modelVC2 = HangmanBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterCharTextField.delegate = self
        gameTextLabel.text = correctLetters.joined(separator: " ")
    }
    @IBOutlet weak var incorrectChars: UITextView!
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        modelVC2.endGame()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text?.count == 1 else {
            return false
        }
        resignFirstResponder()
        modelVC2.wordCheck(enteredChar: Character(textField.text!))
        gameTextLabel.text = correctLetters.joined(separator: " ")
        textField.text = ""
        incorrectChars.text = incorrectLetters.joined(separator: ", ")
//        switch  {
//        case .victory(currentPlayer):
//            print("sdgdsf")
//        case .defeat(currentPlayer):
//            print("sfd")
//        case .onGoing:
//            print("saf")
//        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
