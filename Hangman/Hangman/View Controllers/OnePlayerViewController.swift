//
//  OnePlayerViewController.swift
//  Hangman
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class OnePlayerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var guessedWordLabel: UILabel!
    @IBOutlet weak var numberGuessesRemaining: UILabel!
    @IBOutlet weak var gameResultLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    var hangman = HangmanOnePlayerModel()
    
    override func viewDidLoad() {
        newGame()
        super.viewDidLoad()
        guessTextField.delegate = self
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIBarButtonItem) {
        newGame()
    }
    
    func newGame() {
        hangman.newGame()
        guessedWordLabel.text = hangman.guessWord.joined(separator: " ")
        numberGuessesRemaining.text = "Guesses Remaining:\n\(hangman.numberOfGuessesRemaining)"
        gameResultLabel.text = "Enter a letter from the alphabet 😒"
    }
    
    //NOT FINISHED
    
    //Text Field Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
