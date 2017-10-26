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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //should return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldArr = [playerOneTextField,playerTwoTextField]
        print(textFieldArr)
        if textField == playerOneTextField {
            if let str = playerOneTextField.text {
                model.startGame(str)
                
                hiddenWord.text = String(repeating: "_ ", count: model.wordToGuess.count)
                textField.text = ""
                textField.resignFirstResponder()
                
                return true
            }
        }
        
        
        if textField == playerTwoTextField {
            if let str = playerTwoTextField.text {
                if model.yourAreWrong(Character(str)) {
                    changeImage(model.counter)
                }
                
                displayString = model.displayGuesses(Character(str))
                hiddenWord.text = displayString
                //                hiddenWord.text = textField.text
                textField.text = ""
                textField.resignFirstResponder()
                
                return true
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

}
