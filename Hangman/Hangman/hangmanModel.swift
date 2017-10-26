//
//  hangmanModel.swift
//  Hangman
//
//  Created by C4Q on 10/25/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangmanModel {
    
    var underscoreArr = [Character]()
    var wordToGuess = ""
    var counter = 0
    
    func startGame(_ wordToGuess: String) {
        generatePuzzle(wordToGuess)
    }
    
    func generatePuzzle(_ wordToGuess: String) {
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
            counter += 1
            return true
        }
        
        return false
    }
    
//    switch WinOrLose {
//    case .win:
//
//    case .lose:
//    }
    
    
    
}
    
    
//if counter == 7 : you die
//if arr doesnt contain underscores then you win

//maybe implement the striker on the side
//enum WinOrLose {
//    case win, lose
//}


//gamestate func reset() -> Bool {
//
//}

//make a var for the wordToGuess.count and have the repeating arr repeat to that count instead of the hard count

    
    
    
    
    
    
    
    
    
    
    
    
    


