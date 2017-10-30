//
//  TwoPlayerViewController.swift
//  Hangman
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class PlayerOneViewController: UIViewController, UITextFieldDelegate {

    //Player One Objects
    @IBOutlet weak var playerOnePickAWordLabel: UILabel!
    @IBOutlet weak var playerOneTextField: UITextField!
    
    override func viewDidLoad() {
        if let safePlayerOneTextField = playerOneTextField {
            safePlayerOneTextField.delegate = self
        }
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count <= 1 else {
            return false
        }
        
        print(string, range.lowerBound, range.upperBound)
        
        if textField == playerOneTextField {
            if string == "" || "abcdefghijklmnopqrstuvwxyz".contains(string.lowercased()) {
                playerOnePickAWordLabel.text = "Pick a word for Player 2 to guess."
                return true
            } else {
                playerOnePickAWordLabel.text = "Please use letters from the alphabet."
            }
        }
        return false
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "BeginGame", let text = playerOneTextField.text {
//            if text.count <= 0 {
//                playerOnePickAWordLabel.text = "You must enter at least one character."
//                return false
//            }
//        }
//        return true
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerTwoViewController = segue.destination as? PlayerTwoViewController {
            playerTwoViewController.hangman = HangmanTwoPlayerModel()
            playerTwoViewController.hangman?.getRandomWord(playerOneTextField.text!)
            playerOneTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = playerOneTextField.text, text.count > 0 else {
            playerOnePickAWordLabel.text = "You must enter at least one character."
            return false
        }
        
        performSegue(withIdentifier: "Begin Game", sender: self)
        return true
    }
}
