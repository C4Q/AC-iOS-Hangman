//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBOutlet weak var player1Word: UITextField!
    
    @IBOutlet weak var wordDisplay: UILabel!
    
    @IBOutlet weak var player2Guess: UITextField!
    
    @IBOutlet weak var guessesLeft: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        reset()
        
    }
    
    var model1 = HangmanModel()
    func updateImage () {
        switch model1.guessesRemaning {
        case 6 :
            hangmanImage.image = #imageLiteral(resourceName: "man1")
        case 5:
            hangmanImage.image = #imageLiteral(resourceName: "man2")
        case 4:
            hangmanImage.image
             = #imageLiteral(resourceName: "man3")
        case 3:
            hangmanImage.image = #imageLiteral(resourceName: "man4")
        case 2:
            hangmanImage.image = #imageLiteral(resourceName: "man5")
        case 1:
            hangmanImage.image = #imageLiteral(resourceName: "man6")
        case 0:
            hangmanImage.image = #imageLiteral(resourceName: "man7")
        default :
            hangmanImage.image = nil
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case player1Word :
            guard let word = textField.text else {
              return false
            }
            guard word.count > 2 && word.count < 13 else {
                messageLabel.text = "Word must be 3-12 letters long"
                return false
            }
            
            for c in word {
                guard model1.alphabet.contains(String(c).lowercased()) else {
                    messageLabel.text = "use only letters from a-z"
                    return false
                }
            }
            model1.makeBlankSpacesAndWordArray(word: word.lowercased())
            model1.updateWordDisplay(guess: word.lowercased())
            wordDisplay.text = model1.guessedWord.lowercased()
            messageLabel.text = "Player 2 guess letters"
            textField.isEnabled = false
            player2Guess.isEnabled = true
            textField.resignFirstResponder()
            return true
        case player2Guess :
            return false
        default:
            return false
        }
       
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case player1Word :
            return true
        case player2Guess :
            guard string.count == 1 else {
                return false
            }
            guard string != "" else {
                return false
            }
            guard model1.alphabet.contains(Character(string.lowercased())) else {
                return false
            }
            guard !(textField.text?.contains(Character(string)))! else {
                return false
            }
            switch model1.userGuessResult(guess: string.lowercased()) {
            case .right :
                model1.updateWordDisplay(guess: string.lowercased())
                wordDisplay.text = model1.guessedWord
                updateImage()
                
            case .wrong :
                wordDisplay.text = model1.guessedWord
                guessesLeft.text = "guesses: \(model1.guessesRemaning)"
                updateImage()
                
            default :
                wordDisplay.text = model1.guessedWord
            }
            switch model1.resultPlayer2() {
            case .win :
                messageLabel.text = "Congrats player 2 Wins!"
                textField.isEnabled = false
                textField.resignFirstResponder()
            case.lose :
                messageLabel.text = "Player 1 Wins! The word was \(player1Word.text!)"
                textField.isEnabled = false
                textField.resignFirstResponder()
            case.playing :
                messageLabel.text = "Player 2 guess letters"
            }
            
        default:
            return false
        
       
    }
    return true
    
        
        
    }
    
    
    func reset() {
        player1Word.isEnabled = true
        player1Word.text = ""
        player2Guess.text = ""
        player1Word.isEnabled = true
        messageLabel.text = "Player 1 type a word"
        guessesLeft.text = "guesses: 7"
        wordDisplay.text = ""
        hangmanImage.image = nil 
        model1.resetGame()
    }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black 
            player1Word.delegate = self
            player2Guess.delegate = self
            player2Guess.isEnabled = false
            messageLabel.text = "Player 1 type a word"
            
            

}

}
