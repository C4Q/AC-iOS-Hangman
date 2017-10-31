//
//  HangmanTwoPlayerModel.swift
//  Hangman
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class HangmanTwoPlayerModel: HangmanOnePlayerModel {
    //Public API
    func getRandomWord(_ playerOneWord: String) {
        randomWord = Array(playerOneWord.lowercased()).map{String($0)}
        guessWord = Array(repeatElement("_", count: randomWord.count))
    }    
}
