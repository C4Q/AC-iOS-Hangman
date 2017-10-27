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
    
    var model = HangmanModel()
    var displayString = ""
    
    //Overrides view and sets up text fields
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneTextField.delegate = self
        playerTwoTextField.delegate = self
        //Disables Player Two text Field Until Player One Returns
        //Is this too hard codyy ??
        playerTwoTextField.isEnabled = false
        playerOneTextField.isEnabled = true
        playerOneInstructionLabel.isHidden = false
        hiddenWord.isHidden = true
        playerTwoInstructionLabel.isHidden = true
    }
    
    
    
    //When return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldArr = [playerOneTextField.self ,playerTwoTextField.self ]
        print(textFieldArr)
        
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
        
        
        if textField == playerTwoTextField {
            if let str = playerTwoTextField.text {
                if playerTwoTextField.text?.count == 1 {
                    if model.yourAreWrong(Character(str)) {
                        changeImage(model.counter)
                    }
                
                displayString = model.displayGuesses(Character(str))
                hiddenWord.text = displayString
                textField.text = ""
                textField.resignFirstResponder()
                    if model.youWin(){
                        //disable everything and pop up new view with a restart
                    } else if model.youLoose() {
                        //disable but say you lost and allow for a reset as well
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
    
    func resetLayout() {
        
    }
    func reload() {
        var message = "Player Wins!"
        let alert: UIAlertController = UIAlertController(title: "test", message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "Play Again", style: .cancel, handler: {action in
            
            //Put code here that you want to run after the alertte
            
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
}
