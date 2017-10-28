//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var wordDisplay: UILabel!
    @IBOutlet weak var messageToPlayer: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            messageToPlayer.text = "Invalid Input"
            messageToPlayer.isHidden = false
            return false
        }
        
        
        brain.playerOneString = text
        while brain.newTwoPlayerGame == true {
            brain.playerOnePicksAWordToGuess()
            wordDisplay.text = String(brain.wordToFindAsArray)
            brain.newTwoPlayerGame = false
        }
        
        
        
        
        
        return true
    }
    
    
    
    var secretWord = SecretWord()
    var brain = HangmanBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        //hangmanWord.pickARandomWord() //Use for single Player Mode 
        //wordDisplay.text = String(hangmanWord.wordToFindAsArray)
    }
    
    
    
    
}

