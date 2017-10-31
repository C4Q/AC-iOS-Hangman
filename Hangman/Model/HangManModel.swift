//
//  HangManModel.swift
//  Hangman
//
//  Created by Lisa J on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangManModel {
    var guessedLetter: String = ""
    var numOfGuessesLeft = 7
    var currentWord = [String]()
    var wordSpacesStorage = [Character]()
    
    func strArrAsStr() -> String {
        return currentWord.joined(separator: " ")
    }
    func wordLines() {
        
        print(currentWord)
        for _ in 1...currentWord.count {
            wordSpacesStorage += "_ "
        }
    }
    func checkGuess() {
      // print("?")
        //if currentWord.contains(guessedLetter){
//            for index in currentWord.indices where currentWord.contains(guessedLetter){
//            print(index)
//            }
//            print("correct guess")
        }
//    }
    
}
