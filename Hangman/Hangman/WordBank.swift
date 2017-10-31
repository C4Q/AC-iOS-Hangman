//
//  WordBank.swift
//  Hangman
//
//  Created by Clint Mejia on 10/30/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class WordBank {
 
    var word: String = ""
    var wordLength: Int {
        return word.count
    }
    var wordAsArray: [String] {
        return self.word.characters.map{String($0)}
    }
    init(word: String) {
        self.word = word
    }
}


