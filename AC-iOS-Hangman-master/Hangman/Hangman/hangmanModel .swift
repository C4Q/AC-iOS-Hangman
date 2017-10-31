//
//  hangmanModel .swift
//  Hangman
//
//  Created by C4Q on 10/30/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangmanModel {
    enum GuessState {
        case right, wrong, used
    }
    enum GameState {
        case win
        case loss
        case active
    }
    
    var secretWord = ""
    var guessesRemaning = 7
    var dashesArr = [String]()
    var secretWordArr = [String]()
    var lettersGuessedArr = [String]()
    var alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    func dashCreator(word: String)  {
        dashesArr = Array(repeating: "_", count: word.count)
        for letter in word {
            secretWordArr.append(String(letter))
            secretWord = dashesArr.joined(separator: " ")
        }
    }
    
    func userGuessState (guess: String) -> GuessState {
        if secretWordArr.contains(guess) {
            return .right
        }
            
            
        else if lettersGuessedArr.contains(guess) {
            return .used
        }
        else {
            lettersGuessedArr.append(guess)
            guessesRemaning -= 1
            return .wrong
        }
    }
    
    func userGameState() -> GameState {
        if !dashesArr.contains("_") && guessesRemaning > 0 {
            return .win
        }
        else if guessesRemaning == 0 {
            return .loss
        }
        else {
            return .active
        }
    }
    
    func updateDashes(guess: String) {
        for index in 0..<secretWordArr.count where secretWordArr[index] == guess {
            dashesArr[index] = guess
            secretWord = dashesArr.joined(separator: " ")
            continue
        }
    }
    
    func resetGame () {
        guessesRemaning = 7
        lettersGuessedArr = [String]()
        secretWordArr = [String]()
        dashesArr = [String]()
    }
}
