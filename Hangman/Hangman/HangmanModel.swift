//
//  Hangman Model.swift
//  Hangman
//
//  Created by C4Q on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

var charCount = 0
var playerSelectedWord = ""
var underScores = ""
var playerSelectedWordArr = [Character]()
var wordArr = Array(playerSelectedWord)
var incorrectLetters = [String]()
var correctLetters = [String]()

enum GameState {
    case victory(Player)
    case defeat(Player)
    case onGoing
}

enum Player {
    case one
    case two
}

class HangmanBrain {
    var currentPlayer: Player = .one
    var currentCorrectGuesses: Int = 0
    var currentIncorrectGuesses: Int = 0
    
    func wordToUnderScores(enteredWord: String) -> [Character] {
        
        for _ in 0..<enteredWord.count {
            playerSelectedWord = enteredWord
            charCount += 1
            playerSelectedWordArr.append("_")
            correctLetters.append("_")
            underScores.append("_ ")
        }
        return playerSelectedWordArr
    }
    
    func wordCheck(enteredChar: Character) -> GameState {
        for i in 0..<wordArr.count where enteredChar == wordArr[i] {
           
            if currentIncorrectGuesses == 7 {
                currentIncorrectGuesses = 0
                return .defeat(currentPlayer)
            }
            
            if playerSelectedWord.contains(enteredChar) {
                playerSelectedWordArr[i] = enteredChar
                correctLetters[i] = String(enteredChar)
                currentCorrectGuesses += 1
                if currentCorrectGuesses == playerSelectedWord.count {
                    return .victory(currentPlayer)
                }
                
            } else {
                incorrectLetters.append(String(enteredChar))
                currentIncorrectGuesses += 1
            }
            
        }
        return .onGoing
    }

    func endGame() {
        charCount = 0
        currentIncorrectGuesses = 0
        currentCorrectGuesses = 0
        underScores = ""
        playerSelectedWord = ""
        playerSelectedWordArr = [Character]()
        wordArr = Array(playerSelectedWord)
        incorrectLetters = [String]()
    }
    
    func winCheck() -> GameState {
        if currentCorrectGuesses == playerSelectedWordArr.count {
            currentCorrectGuesses = 0
            return .victory(currentPlayer)
        }
            
        else if currentIncorrectGuesses == 7 {
            currentIncorrectGuesses = 0
            return .defeat(currentPlayer)
        }
        return .onGoing
    }
}












