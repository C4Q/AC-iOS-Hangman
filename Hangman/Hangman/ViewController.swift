//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // //Two Player Hangman Outlets
    
    // Instruction Labels
    @IBOutlet weak var playerOneInstructionLabel: UILabel!
    @IBOutlet weak var playerTwoInstructionLabel: UILabel!
    @IBOutlet weak var hiddenWord: UILabel!
    
    
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
    
    //Overrides view and sets up text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneTextField.delegate = self
        playerTwoTextField.delegate = self
        resetLayout()
        
    }
    
    //Func to check if user is inputting letters only
    func aLetterInAlphabet() -> Bool {
        if (playerOneTextField.text?.contains(alphabet))!{
            
        }
        if (playerTwoTextField.text?.contains(alphabet))! {
            
        }
        return true
    }
    
    //Func makes sure it is one char and disables backspace
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == playerTwoTextField {
            guard let text = playerTwoTextField.text else {
                return false
            }
            if !(text.count > 0) {
                return true
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
                // if the text field does not equal a num code here
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
                //}
            }
            
        }
        
        //Player Two Entry
        
        
        if textField == playerTwoTextField {
            if let str = playerTwoTextField.text {
                if playerTwoTextField.text?.count == 1 {
                    // if the text field does not equal a num code here
                    if model.yourAreWrong(Character(str.lowercased())) {
                        changeImage(model.counter)
                    }
                    
                    displayString = model.displayGuesses(Character(str.lowercased()))
                    hiddenWord.text = displayString
                    textField.text = ""
                    textField.resignFirstResponder()
                    if model.youWin(){
                        winner = "Two"
                        reload()
                        
                    } else if model.youLoose() {
                        winner = "One"
                        reload()
                        
                    }
                    return true
                }
            }
        }
        
        return false
    }
    
    
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
        model.startGame("")
        changeImage(0)
    }
    
    //Reload Func
    func reload() {
        let message = "Player \(winner) Wins!"
        let alert: UIAlertController = UIAlertController(title: "Match Finished", message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "Play Again?", style: .cancel, handler: {action in
            self.resetLayout()
            
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
