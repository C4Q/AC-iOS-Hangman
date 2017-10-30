//
//  TwoPlayerViewController.swift
//  Hangman
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class TwoPlayerPOneViewController: UIViewController, UITextFieldDelegate {

    //Player One Objects
    @IBOutlet weak var playerOnePickAWordLabel: UILabel!
    @IBOutlet weak var playerOneTextField: UITextField!
    
    var hangman = HangmanTwoPlayerModel()
    
    override func viewDidLoad() {
        if let safePlayerOneTextField = playerOneTextField {
            safePlayerOneTextField.delegate = self
        }
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count <= 1 else {
            return false
        }
        
        print(string, range.lowerBound, range.upperBound)
        
        if textField == playerOneTextField {
            if string == "" || "abcdefghijklmnopqrstuvwxyz".contains(string.lowercased()) {
                playerOnePickAWordLabel.text = "Pick a word for Player 2 to guess."
                return true
            } else {
                playerOnePickAWordLabel.text = "Please use letters from the alphabet."
            }
        } else if textField == playerTwoTextField {
            if "abcdefghijklmnopqrstuvwxyz".contains(string.lowercased()) {
                return true
            } else if string == "" {
                gameResultLabel.text = "You cannot delete answers."
            } else {
                gameResultLabel.text = "Please use letters from the alphabet."
            }
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == playerOneTextField {
            if textField.text?.count == 0 {
                playerOnePickAWordLabel.text = "You must enter at least one character."
                return false
            }
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "BeginGame", let text = playerOneTextField.text {
            if text.count <= 0 {
                playerOnePickAWordLabel.text = "You must enter at least one character."
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BeginGame" {
            hangman.getRandomWord(playerOneTextField.text!)
            let guessedWord = hangman.guessWord.joined(separator: " ")
            if let twoPlayerViewController = segue.destination as? TwoPlayerViewController {
                twoPlayerViewController.guessedWordLabel.text = guessedWord
            }
        }
    }
}
