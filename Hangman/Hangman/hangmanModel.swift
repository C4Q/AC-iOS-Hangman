//
//  hangmanModel.swift
//  Hangman
//
//  Created by C4Q on 10/25/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
import UIKit

class HangmanModel {
    
    var underscoreArr = [Character]()
    var charBank = [Character]()
    var wordToGuess = ""
    var counter = 0

    func startGame(_ wordToGuess: String) {
        counter = 0
        generateUnderScores(wordToGuess)
        
    }
    
    func generateUnderScores(_ wordToGuess: String) {
        self.wordToGuess = wordToGuess
        underscoreArr = []
        
        underscoreArr = Array.init(repeating: "_", count: wordToGuess.count)
    }
    
    
    // Every time someone guesses, the textfield should call this function,
    func displayGuesses(_ char: Character) -> String {
        var guessString = ""
        
        for x in 0..<wordToGuess.count where Array(wordToGuess.characters)[x] == char {
            underscoreArr[x] = char
        }
        
        for char in underscoreArr {
            guessString += "\(char) "
        }
        
        return guessString
    }
    
    
    
    
    
    func yourAreWrong(_ char: Character) -> Bool {
        
        if !Set(wordToGuess).contains(char) {
            if !charBank.contains(char){
                charBank.append(char)
                print(charBank)
                counter += 1
                print(counter)
                return true
            }
            
        }
        return false
    }
    
    func youLoose() -> Bool {
        if counter == 6 {
            return true
        }
        return false
    
    }
        func youWin() -> Bool {

            if !underscoreArr.contains("_") && counter < 6 {
                return true
            }
            return false

}

//    func reload() {
//        var message = "Player Wins!"
//        let alert: UIAlertController = UIAlertController(title: "test", message: message, preferredStyle: .alert)
//        let action: UIAlertAction = UIAlertAction(title: "Play Again", style: .cancel, handler: {action in
//            
//          //Put code here that you want to run after the alert
//            
//        })
//        
//        alert.addAction(action)
//        present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//    }




//✓✓✓✓✓✓✓✓✓✓Only allow player two to input a single char ✓
//create a lose of win func where either win or loose the screen is diabled and asks user if they want to play again // only dif is the label will either say player on/two won
//maybe make another view that hides during the game and then pops up for lose win condition
//whats the easiest way to do this UI Style

//win condition // if there are no more underscores, && counter < 6, player two wins
//if counter first reaches 6, player 1 wins

//the restart needs press button and then to call viewDidLoad and reset the counter



    
    
    
    
    
    
    


}
