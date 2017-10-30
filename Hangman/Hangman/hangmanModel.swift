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
    
    //Model Variables
    var underscoreArr = [Character]()
    var charBank = [Character]()
    var wordToGuess = ""
    var counter = 0
    
    //Sets counter to 0 and inputs users input into an arr
    func startGame(_ wordToGuess: String) {
        counter = 0
        generateUnderScores(wordToGuess)
        
    }
    //Creates an image of underscores dependent on the count of the input word
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
    
    
    
    
    //Checks if input is wrong or valid
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
    
    //Loose Function
    func youLoose() -> Bool {
        if counter == 6 {
            return true
        }
        return false
        
    }
    //Win Function
    func youWin() -> Bool {
        
        if !underscoreArr.contains("_") && counter < 6 {
            return true
        }
        return false
        
    }
    
    
    
}





//no spaces allowed DONEEEE
//no deletes allowed DONEEEE
//no ints allowed 

