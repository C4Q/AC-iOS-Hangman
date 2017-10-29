//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var secretWord = SecretWord()
    var brain = HangmanBrain()
    
    @IBAction func resetButton(_ sender: UIButton) {
        resetGame()
    }
    
    @IBAction func oneOrTwoPlayerButtons(_ sender: UIButton) {
        if sender.tag == 1 {
            brain.currentGameState = brain.startOfSinglePlayerGame
            gameStateCheck()
        }
        if sender.tag == 2 {
            brain.currentGameState = brain.startOfTwoPlayerGame
            gameStateCheck()
        }
    }
    @IBAction func DifficultySelectorButtons(_ sender: UIButton) {
        if sender.tag == 3 {
            brain.pickAnEasyRandomWord()
            brain.currentGameState = brain.ongoingSinglePlayerGame
            gameStateCheck()
        }
        if sender.tag == 4 {
            brain.pickAHardRandomWord()
            brain.currentGameState = brain.ongoingSinglePlayerGame
            gameStateCheck()
        }
    }
    @IBOutlet weak var SinglePlayerButton: UIButton!
    @IBOutlet weak var twoPlayerButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var textFieldForGuessing: UITextField!
    @IBOutlet weak var wrongLettersLabel: UILabel!
    @IBOutlet weak var wordDisplay: UILabel!
    @IBOutlet weak var messageToPlayer: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var manImage: UIImageView!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        if let text = textFieldForGuessing.text {
            if brain.correctAnswerArray.contains(text) || brain.wrongAnswerArray.contains(text) {
                messageToPlayer.text = "You picked \"\(text)\" already"
                return true
            }
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            messageToPlayer.text = "Invalid Input"
            messageToPlayer.isHidden = false
            return true
        }
        guard textFieldForGuessing.text != nil else {
            messageToPlayer.text = "Invalid Input"
            messageToPlayer.isHidden = false
            return true
        }
        
        brain.playerOneString = text.lowercased()
        if brain.newTwoPlayerGame == false {
            if brain.wordToFind.contains(brain.playerOneString) == false {
                if brain.wrongAnswerArray.contains(brain.playerOneString) {
                    messageToPlayer.text = "You picked \(brain.playerOneString) already"
                } else {
                    messageToPlayer.text = "That letter was incorrect"
                    wrongLettersLabel.isHidden = false
                    brain.wrongAnswerArray.append(brain.playerOneString)
                    wrongLettersLabel.text = "Wrong Picks: \(brain.wrongAnswerArray)"
                    print(brain.wrongAnswerArray)
                    brain.numWrongAttempts += 1
                }
                if brain.numWrongAttempts > 0 {
                    switch brain.numWrongAttempts {
                    case 1:
                        manImage.image = #imageLiteral(resourceName: "man1")
                    case 2:
                        manImage.image = #imageLiteral(resourceName: "man2")
                    case 3:
                        manImage.image = #imageLiteral(resourceName: "man3")
                    case 4:
                        manImage.image = #imageLiteral(resourceName: "man4")
                    case 5:
                        manImage.image = #imageLiteral(resourceName: "man5")
                    case 6:
                        manImage.image = #imageLiteral(resourceName: "man6")
                    default:
                        manImage.image = #imageLiteral(resourceName: "man7")
                    }
                }
                
            } else {
                if brain.correctAnswerArray.contains(brain.playerOneString) {
                    messageToPlayer.text = "You picked \"\(text)\" already"
                } else {
                    messageToPlayer.text = "You Guessed Correctly!"
                    brain.correctPick()
                    wordDisplay.text = String(describing: brain.answerLengthArray)
                    wrongLettersLabel.text = "Incorrect Picks: \(brain.wrongAnswerArray)"
                }
            }
        }
        //while brain.currentGameState == brain.startOfTwoPlayerGame - doesnt work :/
        
        while brain.newTwoPlayerGame == true {
//            brain.playerOnePicksAWordToGuess()
//            wordDisplay.text = String(brain.wordToFindAsArray)
//            wordDisplay.isHidden = false
//            textField.isHidden = true
//            textFieldForGuessing.isHidden = false
//            messageToPlayer.text = "Player Two - Pick a Letter!"
//            brain.newTwoPlayerGame = false
            brain.currentGameState = brain.ongoingTwoPlayerGame
            gameStateCheck()
        }
        wordDisplay.text = String(describing: brain.answerLengthArray)
        textField.text = ""
        
        brain.winnerCheck()
        if brain.youWin == true {
            messageToPlayer.text = "You Win! The word was \"\(brain.wordToFind)\""
            disableGame()
        }
        if brain.youLost == true {
            messageToPlayer.text = "You're a LOSER! The word was \"\(brain.wordToFind)\""
            disableGame()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textFieldForGuessing.delegate = self
        resetGame()
        
    }
    func disableGame() {
        textFieldForGuessing.isEnabled = false
        resetButtonOutlet.isHidden = false
    }
    func resetGame() {
        manImage.image = nil
        wordDisplay.isHidden = true
        wrongLettersLabel.isHidden = true
        textFieldForGuessing.isHidden = true
        brain.newTwoPlayerGame = true
        brain.youLost = false
        brain.youWin = false
        brain.numWrongAttempts = 0
        brain.wrongAnswerArray = []
        brain.correctAnswerArray = []
        brain.noDupeWrongAnswerArray = []
        brain.noDupeCorrectAnswerArray = []
        brain.answerLengthArray = []
        brain.wordToFind = ""
        resetButtonOutlet.isHidden = true
        textFieldForGuessing.isEnabled = true
        SinglePlayerButton.isHidden = false
        twoPlayerButton.isHidden = false
        textField.isHidden = true
        messageToPlayer.text = "Pick From Below!"
    }
    func gameStateCheck() {
        switch brain.currentGameState {
        case .Beginning(let OneOrTwoPlayer):
            switch OneOrTwoPlayer {
            case .SinglePlayer:
                print("It's the beginning of a singleplayer game.")
                textFieldForGuessing.isHidden = true
                textField.isHidden = true
                messageToPlayer.text = "Player One - Pick a category"
                SinglePlayerButton.isHidden = true
                twoPlayerButton.isHidden = true
                easyButton.isHidden = false
                hardButton.isHidden = false
                brain.newTwoPlayerGame = false
                
            case .TwoPlayer:
                print("It's the beginning of a twoplayer game.")
                messageToPlayer.text = "Player One - Make a Word To Guess"
                easyButton.isHidden = true
                hardButton.isHidden = true
                SinglePlayerButton.isHidden = true
                twoPlayerButton.isHidden = true
                textField.isHidden = false
                brain.newTwoPlayerGame = true
                
            }
        case .Ongoing(let OneOrTwoPlayer):
            switch OneOrTwoPlayer {
            case .SinglePlayer:
                print("It's an ongoing singleplayer game")
                messageToPlayer.text = "Player One - Guess a Letter"
                easyButton.isHidden = true
                hardButton.isHidden = true
                textFieldForGuessing.isHidden = false
                wordDisplay.text = String(describing: brain.answerLengthArray)
                wordDisplay.isHidden = false
            case .TwoPlayer:
                print("It's an ongoing twoplayer game")
                brain.playerOnePicksAWordToGuess()
                wordDisplay.text = String(describing: brain.answerLengthArray)
                wordDisplay.isHidden = false
                textField.isHidden = true
                textFieldForGuessing.isHidden = false
                messageToPlayer.text = "Player Pick a Letter!"
                brain.newTwoPlayerGame = false
            }
        case .End(let OneOrTwoPlayer):
            switch OneOrTwoPlayer {
            case .SinglePlayer:
                print("It's the end of a singleplayer game")
            case .TwoPlayer:
                print("It's the end of a twoplayer game")
            }
        }
        
    }
    
    
}

