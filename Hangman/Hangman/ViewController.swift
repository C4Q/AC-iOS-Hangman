//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //Two Player Hangman
//First View Outlets
    @IBOutlet weak var forestPic: UIImageView!
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    // Instruction Labels
    @IBOutlet weak var playerOneInstructionLabel: UILabel!
    @IBOutlet weak var playerTwoInstructionLabel: UILabel!
    @IBOutlet weak var hiddenWord: UILabel!
    
    @IBOutlet weak var badLetterLabel: UILabel!
    
    //Player Text Fields
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    var textFieldArr: [UITextField] = []
    
    // Hangman Picture
    @IBOutlet weak var hungManPicture: UIImageView!
    
    //View Controller Variables
    var model = HangmanModel()
    var displayString = ""
    var winner = ""
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    var alertMessage = ""
    //Overrides view and sets up text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneTextField.delegate = self
        playerTwoTextField.delegate = self
        resetLayout()
        
    }
    
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        self.forestPic.isHidden = true
        self.WelcomeLabel.isHidden = true
        self.playButton.isHidden = true
    }
    
    
    //Func makes sure it is one char and disables backspace
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Allows Player One to only enter alphabet letters
        if textField == playerOneTextField {
            guard playerOneTextField.text != nil else {
                return false
            }
            if alphabet.contains(string) {
                return true
            }
            return false
        }
        
         //Allows Player One to only enter alphabet letters and 1 char
        if textField == playerTwoTextField {
            guard let text = playerTwoTextField.text else {
                return false
            }
            
            
            if alphabet.contains(string) {
                if !(text.count > 0) {
                    return true
                }
            }
           
           return false
        }
        return true
    }
    
    
    
    //When return is pressed, this code runs
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        


        
        //Player One Entry
        if textField == playerOneTextField {
            if let str = playerOneTextField.text {
                model.startGame(str)
                hiddenWord.text = String(repeating: "_ ", count: model.wordToGuess.count)
                textField.text = ""
                textField.resignFirstResponder()
                
                //Enable and Disable features in view
                playerOneTextField.isEnabled = false
                playerOneInstructionLabel.isHidden = true
                hiddenWord.isHidden = false
                playerTwoInstructionLabel.isHidden = false
                playerTwoTextField.isEnabled = true
                return true
            }
        }
        
        
        //Player Two Entry
        
        
        if textField == playerTwoTextField {
            if let str = playerTwoTextField.text {
                if model.yourAreWrong(Character(str.lowercased())) {
                    badLetterLabel.text = "\(String(model.charBank))"
                    changeImage(model.counter)
                }
                playerTwoInstructionLabel.isHidden = true
                displayString = model.displayGuesses(Character(str.lowercased()))
                hiddenWord.text = displayString
                textField.text = ""
                textField.resignFirstResponder()
                if model.youWin(){
                    winner = "Two"
                    alertMessage = "Lucky..."
                    reload()
                } else if model.youLoose() {
                    winner = "One"
                    alertMessage = "\(model.wordToGuess)"
                    reload()
                }
                return true
            }
        }
        return false
    }
    
    //Changes image throughout wrong guesses
    func changeImage(_ num: Int) {
        let imageName = "man\(num + 1)"
        hungManPicture.image = UIImage(named: imageName)
    }
    
    
    //Reset Func
    func resetLayout() {
        self.playerTwoTextField.isEnabled = false
        self.playerOneTextField.isEnabled = true
        self.playerOneInstructionLabel.isHidden = false
        self.hiddenWord.isHidden = true
        self.playerTwoInstructionLabel.isHidden = true
        self.badLetterLabel.text = "Wrong Letters You Already Used:"
        model.startGame("")
        changeImage(0)
    }
    
    
    //Reload Func
    func reload() {
        let message = "Player \(winner) Wins!"
        let alert: UIAlertController = UIAlertController(title: alertMessage, message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "Play Again?", style: .cancel, handler: {action in
            self.resetLayout()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
