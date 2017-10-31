//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var setWordTextField: UITextField!
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var hangManView: UIView!
    
    @IBOutlet weak var guessResultLabel: UILabel!
    var model = HangManModel()
    var str = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWordTextField.delegate = self
        self.guessTextField.delegate = self
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            model.currentWord = [setWordTextField.text!]//current word
           = model.strArrAsStr()
            model.wordLines()
            wordLabel.text = String(model.wordSpacesStorage)
            //put brain of game here
        }
//
        if textField.tag == 2 {
            if (guessTextField.text?.count)! > 1 {// if more than 1 char is
                guessResultLabel.isHidden = false
                guessResultLabel.text = "1 letter guesses only"
                //print(textField.text!)
            }else{//if only 1 letter guess is entered
                model.guessedLetter = guessTextField.text!
                guessResultLabel.isHidden = true
                model.guessedLetter = guessTextField.text!
                print(model.guessedLetter)
                model.numOfGuessesLeft -= 1
                print(model.numOfGuessesLeft)
               // model.checkGuess
            }
           // textField.text = ""//clears text field
            }
       
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else {
            //print("must enter a letter")
            return true
        }
        guard CharacterSet.letters.contains(UnicodeScalar(string)!) else {
            return false
        }
        return true
    }
}

