//
//  ViewController.swift
//  Hangman
//
//  Copyright © 2017 Reiaz Gafar. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var letterGuessTextField: UITextField!
    @IBOutlet weak var wordEntryTextField: UITextField!
    @IBOutlet weak var enteredLettersLabel: UILabel!
    @IBOutlet weak var wordToGuessLabel: UILabel!
    @IBOutlet weak var chancesLeftLabel: UILabel!

    
    let model = HangmanModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letterGuessTextField.delegate = self
        wordEntryTextField.delegate = self
        letterGuessTextField.isHidden = true
        wordToGuessLabel.text = ""
        chancesLeftLabel.text = String(model.chancesLeft)
        mainImageView.image = model.hangmanImages[model.chancesLeft]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case letterGuessTextField:
            if textField.text != "" {
            model.letter = textField.text!
                model.changeChancesLeft()
                chancesLeftLabel.text = String(model.chancesLeft)
                model.enterLetter(letter: textField.text!)
                model.addLetterToUnderscoreArray()
                model.makeUnderscoreArrayString()
                wordToGuessLabel.text = model.underscoreArrayString
                mainImageView.image = model.hangmanImages[model.chancesLeft]
                textField.text = ""
            }
            if model.isGameOver() == true {
                textField.isHidden = true
                model.makeWordArrayString()
                if model.underscoreArray != model.wordArray {
                    topLabel.text = "The correct word was:"
                    wordToGuessLabel.text = model.wordArrayString
                } else {
                    topLabel.text = "Congratulations You Won"
                }
            }
            textField.resignFirstResponder()
            return true
        case wordEntryTextField:
            model.wordToGuess = textField.text!
            model.makeWordArray()
            model.makeUnderscoreArray()
            model.makeUnderscoreArrayString()
            wordToGuessLabel.text = model.underscoreArrayString
            wordEntryTextField.isHidden = true
            letterGuessTextField.isHidden = false
            textField.resignFirstResponder()
            return true
        default:
            textField.resignFirstResponder()
            return true
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(range.upperBound, range.lowerBound)
        switch textField {
        case letterGuessTextField:
            if textField.text?.count == 1 {
                return false
            }
            if string == "" {
                return true
            }
            if !model.alphabet.contains(string.lowercased()) {
                return false
            }
            if model.enteredLetters.contains(string.lowercased()) {
                topLabel.text = "You've already entered that letter."
                return false
            }
            guard range.upperBound < 1 else {
                return false
            }
            topLabel.text = ""
            return true
        case wordEntryTextField:
            if string == "" {
                return true
            }
            if !model.alphabet.contains(string.lowercased()) {
                return false
            }
            return true
        default:
            return true
        }
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        model.reset()
        letterGuessTextField.text = ""
        chancesLeftLabel.text = String(model.chancesLeft)
        wordEntryTextField.text = ""
        wordToGuessLabel.text = ""
        wordEntryTextField.isHidden = false
        letterGuessTextField.isHidden = true
        mainImageView.image = model.hangmanImages[model.chancesLeft]
        topLabel.text = "Welcome to Hangman"
    }

    
    
}

