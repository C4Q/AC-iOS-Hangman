//
//  hangmanBrain.swift
//  Hangman
//
//  Created by C4Q on 10/27/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
import UIKit


class hangmanBrain {
    
    private let letterBank = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q","r", "s", "t", "u", "v", "w", "x", "y", "z"]
    private var lettersUsed = [String]()
    private var wordOfTheGame = ""
    private var wordStatus = ""
    private var correctLetters = [String]()
    private var numberOfGuesses = 0
    
    
    
    
    
    func lettersOnlyCheck(character: String) -> Bool{
        if letterBank.contains(character){
            return true
        }
        return false
    }
    
    
    
    func wordOfTheGame(word: String) -> String{
        wordOfTheGame = word.lowercased()
        
        for _ in wordOfTheGame{
            wordStatus += "_ "
        }
        
        return wordStatus
    }
    
    
    
    
    
    func checkIfLettersUsed(guess: String) -> Bool{
        if lettersUsed.contains(guess){
            return true
        }
        lettersUsed.append(guess)
        return false
    }
    
    
    func guessCheck(guess: String) -> Bool {
        if wordOfTheGame.contains(guess){
            correctLetters.append(guess)
            return true
        }
        return false
    }
    
    func wordStatusUpdate() -> String{
        wordStatus = ""
        for character in wordOfTheGame{
            if correctLetters.contains(character.description){
                wordStatus += character.description
            }else{
                wordStatus += "_ "
            }
        }
        
        return wordStatus
    }
    
    
    
    
    private let hangmanPictures: [UIImage] = [#imageLiteral(resourceName: "man1"),#imageLiteral(resourceName: "man2"),#imageLiteral(resourceName: "man3"),#imageLiteral(resourceName: "man4"),#imageLiteral(resourceName: "man5"),#imageLiteral(resourceName: "man6"),#imageLiteral(resourceName: "man7")]
    
    
    func updateHangmanImage() -> UIImage{
        let result = hangmanPictures[numberOfGuesses]
        numberOfGuesses += 1
        return result
    }
    
    
    
    func revealWord() -> String {
        return wordOfTheGame
    }
    
    
    func resetGame(){
        wordOfTheGame = ""
        lettersUsed.removeAll()
        correctLetters.removeAll()
        numberOfGuesses = 0
        wordStatus = ""
    }
    
    
    
    
    
    enum gameStatus {
        case won, ongoing, lost
    }
    
    
    
    func checkForWin() -> gameStatus {
        if wordStatus == wordOfTheGame {
            return .won
        }
        if numberOfGuesses == 7{
            return .lost
        }
        return .ongoing
        
    }
    
}


