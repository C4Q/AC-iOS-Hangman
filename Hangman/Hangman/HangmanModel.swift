//
//  HangmanModel.swift
//  Hangman
//
//  Created by C4Q on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
class HangmanModel {
    
    
    enum GuessResult {
        case right
        case wrong
        case used
    }
    
  
    enum GameResult {
        case win
        case lose
        case playing
    }
    
    var guessesRemaning = 7
    var alphabet = "abcdefghijklmnopqrstuvwxyz"
    var displayArray = [String]()
    var wordArr = [String]()
    var usedLetterArr = [String]()
    var guessedWord = ""
    
    func makeBlankSpacesAndWordArray (word: String)  {
        displayArray = Array(repeating: "_", count: word.count)
        for letter in word {
            wordArr.append(String(letter))
            guessedWord = displayArray.joined(separator: " ")
            
        }
        
    }
    
    func userGuessResult (guess: String) -> GuessResult {
        if wordArr.contains(guess) {
            return .right
            }
        
        
        else if usedLetterArr.contains(guess) {
            return .used
        }
        else {
            usedLetterArr.append(guess)
            guessesRemaning -= 1
            return .wrong
        }
    }
   
    func resultPlayer2 () -> GameResult {
        if !displayArray.contains("_") && guessesRemaning > 0 {
            return .win
        }
        else if guessesRemaning == 0 {
          return .lose
        }
        else {
            return .playing
        }
    }
    func updateWordDisplay (guess: String) {
        for index in 0..<wordArr.count where wordArr[index] == guess {
            displayArray[index] = guess
            guessedWord = displayArray.joined(separator: " ")
            continue
        }
        

    }
    
    
    func resetGame () {
        usedLetterArr = [String]()
        wordArr = [String]()
        displayArray = [String]()
        guessesRemaning = 7
        
    }
    
    
    
    
    
    
    
}

