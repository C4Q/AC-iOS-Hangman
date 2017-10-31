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
    @IBOutlet weak var newGameButton: UIButton!
    
    var hangman: HangmanTwoPlayerModel!
    
    override func viewDidLoad() {
        newGameButton.isHidden = true
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
        guard let text = textField.text else {
            return false
        }
        
        if string.count > 1 || text.count == 1 && string != "" {
            gameResultLabel.text = "You can only enter one character at a time 😒"
            return false
        }
        
        if hangman.usedLetters.contains(string) {
            gameResultLabel.text = "You have used this letter already 😂"
            return false
        }
        
        guard "abcdefghijklmnopqrstuvwxyz".contains(string.lowercased()) || string == "" else {
            gameResultLabel.text = "You did not enter a letter 😒"
            return false
        }
        
        if string == "" {
            gameResultLabel.text = "Enter a letter from the alphabet 😒"
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.last else {
            return false
        }
        
        switch hangman.checkLetter(String(text).lowercased()) {
        case .correct:
            guessedWordLabel.text = hangman.guessWord.joined(separator: " ")
            gameResultLabel.text = "😒 Correct 😒"
        case .incorrect:
            gameResultLabel.text = "🔥 Incorrect guess!! 🔥"
            numberGuessesRemaining.text = "Guesses Remaining:\n\(hangman.numberOfGuessesRemaining)"
            switch hangman.numberOfGuessesRemaining {
            case 6:
                hangmanImage.image = #imageLiteral(resourceName: "man1")
            case 5:
                hangmanImage.image = #imageLiteral(resourceName: "man2")
            case 4:
                hangmanImage.image = #imageLiteral(resourceName: "man3")
            case 3:
                hangmanImage.image = #imageLiteral(resourceName: "man4")
            case 2:
                hangmanImage.image = #imageLiteral(resourceName: "man5")
            case 1:
                hangmanImage.image = #imageLiteral(resourceName: "man6")
            case 0:
                hangmanImage.image = #imageLiteral(resourceName: "man7")
            default:
                break
            }
            
        case .used:
            gameResultLabel.text = "You have used this letter already 😂"
            return false
        }
        
        switch hangman.checkWin() {
        case .win:
            gameResultLabel.text = "Congrats... you got the word right 😒"
        case .lose:
            gameResultLabel.text = "Sorry, the correct word was \"\(hangman.randomWord.joined())\".\nBetter luck next time! 😂"
        case .ongoing:
            textField.text? = ""
            return true
        }
        
        textField.resignFirstResponder()
        textField.text? = ""
        textField.isUserInteractionEnabled = false
        newGameButton.isHidden = false
        return false
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
