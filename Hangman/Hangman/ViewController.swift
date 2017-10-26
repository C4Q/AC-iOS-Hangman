//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {
    
    let hangmanBrain = HangmanBrain()
    var delegate: UITextFieldDelegate?
    var guessedLetters: Set<String> = []
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var WordLabel: UILabel!
    @IBOutlet weak var GuessedLetterLabel: UILabel!
    @IBOutlet weak var SuccessLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var DashedWordLabel: UILabel!
    
    @IBAction func MultiplayerButton(_ sender: Any) {
        resetGame()
    }
    @IBAction func VsCompButton(_ sender: Any) {
        resetGame()
        WordLabel.text = hangmanBrain.randWord.word
        DashedWordLabel.text = hangmanBrain.randWord.dashedWord
        
    }
    
    func resetGame() {
        hangmanBrain.getRandomWord()
        TextField.isEnabled = true
        TextField.text?.removeAll()
        guessedLetters = []
        ScoreLabel.text = hangmanBrain.updateGuesses(increment: false)
        GuessedLetterLabel.text = String(describing: guessedLetters)
    }
    
    func setUp() {
        TextField.isEnabled = false
        ScoreLabel.text = hangmanBrain.updateGuesses(increment: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let unicodeString = UnicodeScalar(string) else {
            SuccessLabel.text = "\(string) is funny!"
            return false
        }
        
        guard CharacterSet.lowercaseLetters.contains(unicodeString) else {
            SuccessLabel.text = "\(string) not in a-z."
            return false
        }
        
        guard !guessedLetters.contains(string) else {
            SuccessLabel.text = "\(string) already chosen."
            return false
        }
        //        WordLabel.text = string
        ScoreLabel.text = hangmanBrain.updateGuesses(increment: true)
        GuessedLetterLabel.text = hangmanBrain.updateGuessedLetters(letter: string)
        TextField.text?.removeAll()
        checkLetter(letter: string)
        return true
    }
    
    func checkLetter(letter: String) {
        if hangmanBrain.randWord.word.contains(letter) {
            print(hangmanBrain.randWord.word)
            print("Good job.")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.TextField.delegate = self
        setUp()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

