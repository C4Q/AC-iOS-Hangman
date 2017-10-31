//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    var model = HangmanModel()
    @IBOutlet weak var guessingWord: UILabel!
    @IBOutlet weak var hangManImage: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var guessingTextField: UITextField!
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var newGameLabel: UIButton!
    
    @IBAction func newGame(_ sender: UIButton) {
        TopLabel.text = "Enter A Word"
        model.guessesLeft = 7
        guessingWord.text = ""
        inputTextField.isHidden = false
        newGameLabel.isHidden = true
        guessingTextField.isUserInteractionEnabled = true
        model.letterBank = [String]()
        hangManImage.isHidden = true
    }
    override func viewDidLoad() {
        inputTextField.delegate = self
        guessingTextField.delegate = self
        super.viewDidLoad()
    }
    
    func theManThatHangs() {
        if model.guessesLeft == 6 {
            hangManImage.isHidden = false
            hangManImage.image = #imageLiteral(resourceName: "man1")
        } else if model.guessesLeft == 5 {
            hangManImage.image = #imageLiteral(resourceName: "man2")
        } else if model.guessesLeft == 4 {
            hangManImage.image = #imageLiteral(resourceName: "man3")
        } else if model.guessesLeft == 3 {
            hangManImage.image = #imageLiteral(resourceName: "man4")
        } else if model.guessesLeft == 2 {
            hangManImage.image = #imageLiteral(resourceName: "man5")
        } else if model.guessesLeft == 1 {
            hangManImage.image = #imageLiteral(resourceName: "man6")
        } else if model.guessesLeft == 0 {
            hangManImage.image = #imageLiteral(resourceName: "man7")
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        switch textField.tag {
        case 0:
            return true
        case 1:
            guard let text = textField.text?.lowercased() else {
                return false
            }
            if !(text.count > 0) {
                return true
            }
            return false
        default:
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            hiddenWord()
            TopLabel.text = "Enter A Letter"
            inputTextField.text = ""
        case 1:
            guard let letter = guessingTextField.text?.lowercased() else {
                return false
            }
            guessingTextField.text = ""
            if model.letterBank.contains(letter) || letter == "" {
                return false
            }
            model.letterBank.append(letter)
            model.entryArray = model.guessLogic(letter, model.winningWord, model.entryArray)
            guessingWord.text = String(model.entryArray).uppercased()
            if model.comparedArrayForWrongGuess == model.entryArray {
                model.guessesLeft -= 1
            } else {
                model.comparedArrayForWrongGuess = model.entryArray
            }
            theManThatHangs()
            winOrLoss()
            return true
        default:
            return false
        }
        textField.resignFirstResponder()
        return true
    }
    
    func resultActions() {
        guessingTextField.isUserInteractionEnabled = false
        newGameLabel.isHidden = false
        guessingWord.text = String(model.winningWord).uppercased()
    }
    func winOrLoss() {
        if model.guessesLeft == 0 {
            TopLabel.text = "Game Over!"
            resultActions()
        } else if String(model.entryArray) == String(model.winningWord) {
            TopLabel.text = "You Win!"
            resultActions()
        }
    }
    func hiddenWord() {
        guard let text = inputTextField.text?.lowercased() else {
            return
        }
        model.winningWord = Array(text)
        model.entryArray = model.playerOne(text)
        model.comparedArrayForWrongGuess = model.entryArray
        guessingWord.text = String(model.entryArray).uppercased() //Underscores displayed
        inputTextField.isHidden = true
    }
}



