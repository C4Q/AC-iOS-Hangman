//
//  ViewController.swift
//  HangMan1.1
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Glo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var hangManModel = HangMan()
    @IBOutlet weak var WordDisplay: UILabel!
    @IBOutlet weak var UserEntry: UITextField!
    @IBOutlet weak var GameTalkToUser: UILabel!
    @IBOutlet weak var PlayerOneUserEntry: UITextField!
    @IBOutlet weak var HangmanImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserEntry.delegate = self
        PlayerOneUserEntry.delegate = self
        NewGame()
    }
    
    @IBAction func NewGamePressed(_ sender: UIButton) {
        NewGame()
    }
    
    
    // Limits Characters in Text Field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case PlayerOneUserEntry:
            //    from https://stackoverflow.com/questions/43181019/make-uitextfield-accept-small-alphabet-letter-only-in-swift
            if string.isEmpty {
                //Allows backspace
                return true
            }
            let regex = "[a-z]{1,}"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string)
            
        case UserEntry:
            let regex = "[a-z]{1,}"

            //https://stackoverflow.com/questions/29763330/how-to-limit-uitextfield-character-range-upto-10-digit
            let charsLimit = 1
            let startingLength = textField.text?.characters.count ?? 0
            let lengthToAdd = string.characters.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit && NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: string)
            
        default:
            return true
            
        }
        
    }
    
    //Results for Users' Input
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        if (textField == self.PlayerOneUserEntry) {
            hangManModel.playerOneWord(text)
            hangManModel.wordForGame()
            PlayerOneUserEntry.isHidden = true
            UserEntry.isHidden = false
            GameTalkToUser.text = "Player Two may begin guessing."
            WordDisplay.text = hangManModel.wordsRevealed
        }
        
        if (textField == self.UserEntry) {
            hangManModel.changeBlankSpaces(text)
            WordDisplay.text = hangManModel.wordsRevealed
            switch hangManModel.outcome {
            case .correct:
                GameTalkToUser.text = "Yes, it has \(text)."
            case .wrong:
                GameTalkToUser.text = "Nope."
            case .usedAlready:
                GameTalkToUser.text = "You already did that! "
            }
            textField.text = ""
        }
        hangManAppears()
        winCondition()
        
        textField.resignFirstResponder()
        return false
    }
    
    
    func winCondition() {
        if hangManModel.counterForHangManReveal == 0 {
            lockUpGame()
            GameTalkToUser.text = "You have lost. The correct word was \(hangManModel.wordOfGame)."
        }
        if hangManModel.wordsRevealed == hangManModel.wordOfGame {
            lockUpGame()
            GameTalkToUser.text = "Congrats! You have won. It took you \(hangManModel.counterForAmountOfGuess) tries."
        }
    }
    
    
    func lockUpGame() {
        UserEntry.isEnabled = false
    }
    
    
    func hangManAppears () {
        switch hangManModel.counterForHangManReveal {
        case _ where hangManModel.counterForHangManReveal == 5:
            HangmanImage.image = #imageLiteral(resourceName: "man2")
        case _ where hangManModel.counterForHangManReveal == 4:
            HangmanImage.image = #imageLiteral(resourceName: "man3")
        case _ where hangManModel.counterForHangManReveal == 3:
            HangmanImage.image = #imageLiteral(resourceName: "man4")
        case _ where hangManModel.counterForHangManReveal == 2:
            HangmanImage.image = #imageLiteral(resourceName: "man5")
        case _ where hangManModel.counterForHangManReveal == 1:
            HangmanImage.image = #imageLiteral(resourceName: "man6")
        case _ where hangManModel.counterForHangManReveal == 0:
            HangmanImage.image = #imageLiteral(resourceName: "man7")
        default:
            break
        }    
    }
    
    func NewGame() {
        hangManModel.counterForAmountOfGuess = 0
        hangManModel.counterForHangManReveal = 6
        hangManModel.wordOfGame = ""
        hangManModel.wordsHidden  = []
        hangManModel.wordsRevealed = ""
        WordDisplay.text = hangManModel.wordsRevealed
        UserEntry.isHidden = true
        UserEntry.isEnabled = true
        PlayerOneUserEntry.isHidden = false
        HangmanImage.image = #imageLiteral(resourceName: "man1")
        PlayerOneUserEntry.text = ""
        GameTalkToUser.text = "Welcome to HangMan. Player one, pick a word. You can only use letters in the alphabet. No !, 2, >, etc."
    }
}








