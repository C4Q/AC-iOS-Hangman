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
    @IBOutlet weak var guessingTextField: UITextField!
    @IBOutlet weak var secureTextField: UITextField!
    @IBOutlet weak var hangManAnimation: UIImageView!
    @IBOutlet weak var attemptsRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessingTextField.delegate = self
        self.secureTextField.delegate = self
        updateGame()
    }
    
    var game = Hangman()
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == secureTextField {
            return true
        }
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        if textField == guessingTextField && !game.potentialLetters.contains(string) {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let string = textField.text else {
            return false
        }
        if string == "" {
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
            attemptsRemainingLabel.text = game.guessesLeftTracker()
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
            attemptsRemainingLabel.isHidden = true
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            guessingTextField.isHidden = true
            secureTextField.isHidden = true
        case .failed:
            attemptsRemainingLabel.isHidden = true
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            guessingTextField.isHidden = true
            secureTextField.isHidden = true
        case .onGoing:
            attemptsRemainingLabel.isHidden = false
            mysteryWordLabel.isHidden = false
            potentialLettersLabel.isHidden = false
            guessingTextField.isHidden = false
            secureTextField.isHidden = true
        case .enterMysteryWord:
            attemptsRemainingLabel.isHidden = true
            mysteryWordLabel.isHidden = true
            potentialLettersLabel.isHidden = true
            guessingTextField.isHidden = true
        }
    }
}


