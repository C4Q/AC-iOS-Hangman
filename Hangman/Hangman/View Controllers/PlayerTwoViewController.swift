//
//  TwoPlayerPOneViewController.swift
//  Hangman
//
//  Created by C4Q on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class PlayerTwoViewController: UIViewController, UITextFieldDelegate {

    //Player Two Objects
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessedWordLabel: UILabel!
    @IBOutlet weak var numberGuessesRemaining: UILabel!
    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var playerTwoTextField: UITextField!
    
    var hangman: HangmanTwoPlayerModel!
    
    override func viewDidLoad() {
        guessedWordLabel.text = hangman.guessWord.joined(separator: " ")
        numberGuessesRemaining.text = "Guesses Remaining:\n\(hangman.numberOfGuessesRemaining)"
        gameResultLabel.text = "Please enter a letter from the alphabet."
        super.viewDidLoad()
        playerTwoTextField.delegate = self
        playerTwoTextField.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.count <= 1, string != "" else {
            gameResultLabel.text = "Stop trying to delete answers 😒"
            return false
        }
        
        guard "abcdefghijklmnopqrstuvwxyz".contains(string.lowercased()) else {
            gameResultLabel.text = "You did not enter a letter 😒"
            return false
        }
        
        switch hangman.checkLetter(string) {
        case .correct:
            guessedWordLabel.text = hangman.guessWord.joined(separator: " ")
        case .incorrect:
            gameResultLabel.text = "Incorrect guess."
            numberGuessesRemaining.text = "Guesses Remaining:\n\(hangman.numberOfGuessesRemaining)"
        case .used:
            gameResultLabel.text = "You have used this letter already 😂"
            return false
        }
        
        switch hangman.checkWin() {
        case .win:
            gameResultLabel.text = "Congrats... you got the word right 😒"
        case .lose:
            gameResultLabel.text = "Sorry, the correct word was \"\(hangman.randomWord)\".\nBetter luck next time! 😂"
        case .ongoing:
            return true
        }
        
        textField.resignFirstResponder()
        textField.text?.append(string)
        textField.isUserInteractionEnabled = false
        return false
    }
    
}
