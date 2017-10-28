//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputSecureWord: UITextField!
    @IBOutlet weak var inputLetterGuess: UITextField!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var wrongGuessesLabel: UILabel!
    @IBOutlet weak var guessWordLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var newGameButton: UIButton!
    
    var hangmanModel = HangmanModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputLetterGuess.delegate = self
        inputSecureWord.delegate = self
        inputLetterGuess.isHidden = true
        guessWordLabel.isHidden = true
        newGameButton.isHidden = true
        turnLabel.isHidden = true
        wrongGuessesLabel.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == inputSecureWord {
            if string == "" {
                return true
            }
            guard HangmanModel.inputAllowed.contains(string.lowercased()) && range.upperBound < 12 else {
                return false
            }
            return true
        }
        if textField == inputLetterGuess {
            if string == "" {
                return true
            }
            guard HangmanModel.inputAllowed.contains(string.lowercased()) && range.upperBound < 1 else {
                return false
            }
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == inputSecureWord {
            guard let textInTextfield = textField.text else {
                return false
            }
            if textInTextfield == "" {
                messageLabel.text = "Enter a word for Player 2 to guess"
                return false
            }
            hangmanModel.setWordToGuess(word: textInTextfield.lowercased())
            guessWordLabel.text = hangmanModel.wordGuessedSoFarWithSpaces()
            inputLetterGuess.isHidden = false
            guessWordLabel.isHidden = false
            messageLabel.text = "Player 2: Time to guess"
            turnLabel.isHidden = false
            wrongGuessesLabel.isHidden = false
            textField.resignFirstResponder()
            textField.isHidden = true
            return true
        }
        
        if textField == inputLetterGuess {
            guard let letterEntered = textField.text else {
                return false
            }
            if letterEntered == "" {
                messageLabel.text = "Enter a letter to guess"
                return false
            }
            if hangmanModel.letterAlreadyEntered(letter:Character(letterEntered.lowercased())) {
                messageLabel.text = letterEntered.uppercased() + " already entered"
                textField.text = ""
                textField.resignFirstResponder()
                return false
            }
            if hangmanModel.contains(letter: Character(letterEntered.lowercased())) {
                messageLabel.text = letterEntered.uppercased() + " found in word"
                guessWordLabel.text = hangmanModel.wordGuessedSoFarWithSpaces()
                if hangmanModel.hasGuessedWord() {
                    messageLabel.text = "You guessed the word!"
                    inputLetterGuess.isHidden = true
                    newGameButton.isHidden = false
                }
            } else {
                messageLabel.text = letterEntered.uppercased() + " not in word"
                wrongGuessesLabel.text = "Wrong Guesses: " + hangmanModel.getWrongGuesses().description
                updateHangman(wrongGuess: hangmanModel.getWrongGuesses())
                if hangmanModel.playerHasLost() {
                    messageLabel.text = "You were hanged"
                    guessWordLabel.text = "Word was: " + hangmanModel.getWordToGuess().uppercased()
                    newGameButton.isHidden = false
                    inputLetterGuess.isHidden = true
                }
            }
            textField.text = ""
            turnLabel.text = "Turn: " + hangmanModel.getTurnsSoFar().description
            textField.resignFirstResponder()
            return true
        }
        return false
    }

    func updateHangman(wrongGuess: Int) {
        switch wrongGuess {
        case 1:
            hangmanImage.image = UIImage(named: "man1")
        case 2:
            hangmanImage.image = UIImage(named: "man2")
        case 3:
            hangmanImage.image = UIImage(named: "man3")
        case 4:
            hangmanImage.image = UIImage(named: "man4")
        case 5:
            hangmanImage.image = UIImage(named: "man5")
        case 6:
            hangmanImage.image = UIImage(named: "man6")
        case 7:
            hangmanImage.image = UIImage(named: "man7")
        default:
            print("Something went wrong")
        }
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        hangmanModel.resetGame()
        messageLabel.text = "Player 1: Enter a word to guess"
        turnLabel.text = "Turn: 1"
        wrongGuessesLabel.text = "Wrong Guesses: 0"
        inputSecureWord.isHidden = false
        inputSecureWord.text = ""
        inputSecureWord.isEnabled = true
        guessWordLabel.text = ""
        guessWordLabel.isHidden = true
        newGameButton.isHidden = true
        hangmanImage.image = UIImage(named: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
