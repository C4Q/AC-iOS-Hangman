//
//  HangManBrain.swift
//  HangMan1.1
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Glo. All rights reserved.
//

import UIKit

enum CheckInput {
    case correct, wrong, usedAlready
}

enum EndGame {
    case win, lose
}

enum Players {
    case playerOne, playerTwo
}

class HangMan {
    
    var counterForHangManReveal = 7
    var counterForAmountOfGuess = 0
    var wordOfGame = String()
    var wordsHidden = Array<String>()
    var wordsRevealed = String()
    var usedLetters = [String]()

    
    func playerOneWord(_ word: String) {
        wordOfGame = word
    }
    
    func wordForGame() {
        
        for _ in wordOfGame {
            wordsHidden.append("_")
        }
        
    }
    

    var correctGuess = false
    var outcome = CheckInput.correct
    func changeBlankSpaces(_ userGuess: String) -> CheckInput  {
        usedLetters.append(userGuess)
        var rightLetter = (alpha: "", index: 0)

        if wordsRevealed.contains(userGuess) {
            counterForAmountOfGuess += 1
            outcome = CheckInput.usedAlready
            return outcome
        }
        
        else if !wordOfGame.contains(userGuess) {
            counterForAmountOfGuess += 1
            counterForHangManReveal -= 1
            outcome = CheckInput.wrong
            return outcome
        }
        
       
        
        for (index, letter) in wordOfGame.enumerated() {
            if userGuess.lowercased() == String(letter) {
                correctGuess = true
                rightLetter.alpha += String(letter)
                rightLetter.index += index
                outcome = CheckInput.correct
                for arrayIndex in 0...wordsHidden.count where arrayIndex == rightLetter.index{
                    wordsHidden[arrayIndex] = rightLetter.alpha
                    rightLetter.index = 0
                    rightLetter.alpha = ""
                    wordsRevealed = wordsHidden.joined()

                }
            }
        }
        
        if correctGuess == true {
            counterForAmountOfGuess += 1
        }
        
         return outcome
    }
}

