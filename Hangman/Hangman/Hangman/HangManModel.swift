//
//  HangManModel.swift
//  Hangman
//
//  Created by C4Q on 10/25/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangmanModel {
    var winningWord = [Character]()
    var entryArray = [Character]()
    var comparedArrayForWrongGuess = [Character]()
    var guessesLeft = 7
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    var letterBank = [String]()

    
    
    func guessLogic(_ guessedLetter: String, _ word: [Character], _ entry: [Character] ) -> [Character] {
        var currentState = entry
        let character = Character(guessedLetter)
        if word.contains(character) {
            for index in 0..<word.count where word[index] == character {
                currentState[index] = character
            }
            return currentState
        }
        return currentState
    }
    func playerOne(_ input: String) -> [Character] {
        let wordCount = input.count
        let wordArray = [input]
        var arrayOfUnderscores = [Character]()
        for _ in 0..<Int(wordCount) {
            arrayOfUnderscores.append("_")
        }
        return arrayOfUnderscores
    }
    
}
