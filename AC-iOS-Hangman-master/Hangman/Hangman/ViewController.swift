//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let hangmanModel = HangmanModel()
    
    @IBOutlet weak var hangManImage: UIImageView!
    @IBOutlet weak var secretWordInputField: UITextField!
    @IBOutlet weak var guessWordInputField: UITextField!
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var guessesRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        secretWordInputField.delegate = self
        guessWordInputField.delegate = self
        guessWordInputField.isEnabled = false
        secretWordInputField.isHidden = false
        messageLabel.text = "Player 1 enter a secret word below"
    }
    
    @IBAction func NewGameButton(_ sender: UIButton) {
        reset()
    }
    
    //Hangman Image
    func hangmanPic() {
        if hangmanModel.guessesRemaning == 6 {
            hangManImage.isHidden = false
            hangManImage.image = #imageLiteral(resourceName: "man1")
        } else if hangmanModel.guessesRemaning == 5 {
            hangManImage.image = #imageLiteral(resourceName: "man2")
        } else if hangmanModel.guessesRemaning == 4 {
            hangManImage.image = #imageLiteral(resourceName: "man3")
        } else if hangmanModel.guessesRemaning == 3 {
            hangManImage.image = #imageLiteral(resourceName: "man4")
        } else if hangmanModel.guessesRemaning == 2 {
            hangManImage.image = #imageLiteral(resourceName: "man5")
        } else if hangmanModel.guessesRemaning == 1 {
            hangManImage.image = #imageLiteral(resourceName: "man6")
        } else if hangmanModel.guessesRemaning == 0 {
            hangManImage.image = #imageLiteral(resourceName: "man7")
        }
    }
    //For Textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case secretWordInputField :
            guard let word = textField.text else {
                return false
            }
            guard word.count > 2 && word.count < 13 else {
                messageLabel.text = "Word must be 3-12 letters long"
                return false
            }
            
            for letter in word {
                guard hangmanModel.alphabet.contains(String(letter).lowercased()) else {
                    messageLabel.text = "Use only letters from a-z"
                    return false
                }
            }
            hangmanModel.dashCreator(word: word.lowercased())
            hangmanModel.updateDashes(guess: word.lowercased())
            dashLabel.text = hangmanModel.secretWord.lowercased()
            messageLabel.text = "Player 2 guess letters"
            textField.isEnabled = false
            guessWordInputField.isEnabled = true
            secretWordInputField.isHidden = true
            textField.resignFirstResponder()
            return true
        case guessWordInputField :
            return false
        default:
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case secretWordInputField :
            return true
        case guessWordInputField :
            guard string.count == 1 else {
                return false
            }
            guard string != "" else {
                return false
            }
            guard hangmanModel.alphabet.contains(Character(string.lowercased())) else {
                return false
            }
            guard !(textField.text?.contains(Character(string)))! else {
                return false
            }
            switch hangmanModel.userGuessState(guess: string.lowercased()) { //RIGHT OR WRONG
            case .right :
                hangmanModel.updateDashes(guess: string.lowercased())
                dashLabel.text = hangmanModel.secretWord
                hangmanPic()
            case .wrong :
                dashLabel.text = hangmanModel.secretWord
                guessesRemainingLabel.text = "Guesses left: \(hangmanModel.guessesRemaning)"
                hangmanPic()
            default :
                dashLabel.text = hangmanModel.secretWord
            }
            switch hangmanModel.userGameState() { //WIN or LOSE
            case .win :
                messageLabel.text = "Player 2 Wins!"
                textField.isEnabled = false
                guessWordInputField.text = ""
                textField.resignFirstResponder()
            case.loss :
                messageLabel.text = "Player 1 Wins! The word was: \(secretWordInputField.text!)"
                textField.isEnabled = false
                guessWordInputField.text = ""
                textField.resignFirstResponder()
            case.active :
                messageLabel.text = "Player 2 guess letters"
            }
        default:
            return false
        }
        return true
    }
    
    func reset() {
        secretWordInputField.isEnabled = true
        secretWordInputField.isHidden = false
        guessWordInputField.isEnabled = true
        secretWordInputField.text = ""
        guessWordInputField.text = ""
        messageLabel.text = "Player 1 enter a secret word"
        guessesRemainingLabel.text = "Guesses left: 7"
        dashLabel.text = ""
        hangManImage.image = nil
        hangmanModel.resetGame()
    }
}
