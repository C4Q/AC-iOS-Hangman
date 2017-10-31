//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mysteryWordLabel: UILabel!
    @IBOutlet weak var potentialLettersLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var secureTextField: UITextField!
    @IBOutlet weak var hangManAnimation: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.secureTextField.delegate = self
        updateGame()
    }
    
    var game = Hangman()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        if (textField.text as NSString?)?.replacingCharacters(in: range, with: string).unicodeScalars.count == 1 {
            return true
        }
        guard textField != secureTextField else  {
            return true
        }
        guard let string = textField.text, potentialLettersLabel.text!.contains(string) else {
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let string = textField.text else {
            return false
        }
        guard textField != secureTextField else {
            game.checkInputForValid(string: string)
            secureTextField.resignFirstResponder()
            secureTextField.text = ""
            updateGame()
            return true
        }
        
        if game.checkInputForValid(string: string.lowercased()) {
            updateGame()
            secureTextField.resignFirstResponder()
            textField.text = ""
            return true
        }
        return true
    }
    
    func updateGame() {
        guard game.gameStatus != .enterMysteryWord else {
            hideLabels(when: .enterMysteryWord)
            gameStatusLabel.text = game.gameStatus.rawValue
            return
        }
        guard game.gameStatus != .onGoing else {
            hideLabels(when: .onGoing)
            gameStatusLabel.text = game.gameStatus.rawValue
            mysteryWordLabel.text = game.mysterWordInProgress.joined()
            potentialLettersLabel.text = ("Potential letters: \n\(game.potentialLetters.joined())")
            return
        }
        guard game.gameStatus == .victorious else {
            hideLabels(when: .failed)
            gameStatusLabel.text = game.gameStatus.rawValue
            return
        }
        hideLabels(when: .victorious)
        gameStatusLabel.text = game.gameStatus.rawValue
        return
    }
    
    
    func hideLabels(when: Hangman.GameStatus){
        hangManAnimation.image = UIImage(named: game.hangmanImage)
        switch when {
        case .victorious:
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            textField.isHidden = true
            secureTextField.isHidden = true
        case .failed:
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            textField.isHidden = true
            secureTextField.isHidden = true
        case .onGoing:
            mysteryWordLabel.isHidden = false
            potentialLettersLabel.isHidden = false
            textField.isHidden = false
            secureTextField.isHidden = true
        case .enterMysteryWord:
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            textField.isHidden = true
        }
    }
}


