//
//  HangmanModel.swift
//  Hangman
//
//  Created by Luis Calle on 10/24/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangmanModel {
    static var inputAllowed: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private var wrongGuesses = 0
    private var currentTurn = 1
    private var wordToGuess = ""
    private var wordChosenArray: [Character] = []
    private var copyWordArray: [Character] = []
    private var lettersEntered: [Character] = []
    
    func contains(letter: Character) -> Bool {
        lettersEntered.append(letter)
        currentTurn += 1
        if wordToGuess.contains(letter) {
            for ind in 0..<wordChosenArray.count {
                if wordChosenArray[ind] == letter {
                    copyWordArray[ind] = letter
                }
            }
            return true
        }
        else {
            wrongGuesses += 1
            return false
        }
    }
    
    func resetGame() {
        self.wrongGuesses = 0
        self.currentTurn = 1
        self.wordToGuess = ""
        self.wordChosenArray = []
        self.copyWordArray = []
        self.lettersEntered = []
    }
    
    func letterAlreadyEntered(letter: Character) -> Bool {
        return lettersEntered.contains(letter)
    }
    
    func hasGuessedWord() -> Bool {
        return wordToGuess == String(copyWordArray)
    }
    
    func playerHasLost() -> Bool {
        return wrongGuesses == 7
    }
    
    func setWordToGuess(word: String) {
        self.wordToGuess = word
        self.wordChosenArray = Array(word.characters)
        self.copyWordArray = Array(repeating: "_", count: word.count)
    }
    
    func wordGuessedSoFarWithSpaces() -> String {
        return copyWordArray.reduce("", {String($0) + " " + String($1)}).uppercased()
    }
    
    func wordToGuessWithSpaces() -> String {
        return wordChosenArray.reduce("", {String($0) + " " + String($1)}).uppercased()
    }
    
    func getWrongGuesses() -> Int {
        return self.wrongGuesses
    }
    
    func getTurnsSoFar() -> Int {
        return self.currentTurn
    }
    
    func getWordToGuess() -> String {
        return wordToGuess
    }
    
}
