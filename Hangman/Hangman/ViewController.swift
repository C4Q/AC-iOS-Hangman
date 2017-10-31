//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var hangmanPicture: UIImageView!
    @IBOutlet weak var letterGuess: UITextField!
    @IBOutlet weak var lettersGuessedDisplay: UILabel!
    @IBOutlet weak var wordChosen: UITextField!
    @IBOutlet weak var gameStatus: UILabel!
    let hangmanModel = hangmanBrain()
    
    @IBOutlet weak var displayWordOfGame: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        letterGuess.delegate = self
        wordChosen.delegate = self
    }

   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        switch textField {
        case wordChosen:
            if hangmanModel.lettersOnlyCheck(character: string.lowercased()) == true || isBackSpace == -92{
                return true
            }
            return false
        default:
            switch hangmanModel.lettersOnlyCheck(character: string.lowercased()){
            case true:
                
                guard hangmanModel.checkIfLettersUsed(guess: string) != true else{
                    gameStatus.isHidden = false
                    gameStatus.text = "Letter already used!"
                    textField.resignFirstResponder()
                    return false
                }
                
                gameStatus.isHidden = true
                switch hangmanModel.guessCheck(guess: string){
                case true:
                 let update = hangmanModel.wordStatusUpdate()
                 displayWordOfGame.text = "Word of the game: " + update
                    
                    
                case false:
                lettersGuessedDisplay.text = lettersGuessedDisplay.text! + "\(string.lowercased()) "
                hangmanPicture.image = hangmanModel.updateHangmanImage()
                }
                
                
                switch hangmanModel.checkForWin(){
                case .won:
                    gameStatus.isHidden = false
                    gameStatus.text = "You Won!"
                      letterGuess.isEnabled = false
                      letterGuess.isHidden = true
                    newGameButton.isHidden = false
                    newGameButton.isEnabled = true
                    
                case .lost:
                    displayWordOfGame.text = "Word of the game: " + hangmanModel.revealWord()
                    gameStatus.isHidden = false
                    gameStatus.text = "You Lost!"
                    letterGuess.isEnabled = false
                    letterGuess.isHidden = true
                    newGameButton.isHidden = false
                    newGameButton.isEnabled = true
                    
                case .ongoing:
                    break
                }
                
                
                textField.resignFirstResponder()
                return true
            
            
            case false:
                return false
            }
      }
        
    }
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        guard let word = textField.text else {
            return false
        }
        guard word != "" else {
            return false
        }
        
        
        switch textField {
        case wordChosen:
         displayWordOfGame.text = displayWordOfGame.text! + hangmanModel.wordOfTheGame(word: word)
          wordChosen.isEnabled = false
          wordChosen.isHidden = true
          letterGuess.isHidden = false
          letterGuess.isEnabled = true
            
        default:
            return true
        }
        

        
        textField.resignFirstResponder()
        return true
    }
    
    

    
    @IBAction func newGamePressed(_ sender: UIButton) {
        hangmanModel.resetGame()
        hangmanPicture.image = nil
        wordChosen.text = nil
        displayWordOfGame.text = ""
        wordChosen.isEnabled = true
        wordChosen.isHidden = false
        gameStatus.isHidden = true
        lettersGuessedDisplay.text = "Letters Guessed: "
        displayWordOfGame.text = "Word of the game: "
        newGameButton.isHidden = true
        newGameButton.isEnabled = false
    }
    
    
    
}
