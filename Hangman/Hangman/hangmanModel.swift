//
//  hangmanModel.swift
//  Hangman
//
//  Copyright © 2017 Reiaz Gafar. All rights reserved.
//

import Foundation
import UIKit

class HangmanModel {
    
    let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    let hangmanImages: [UIImage] = [#imageLiteral(resourceName: "man7"), #imageLiteral(resourceName: "man6"), #imageLiteral(resourceName: "man5"), #imageLiteral(resourceName: "man4"), #imageLiteral(resourceName: "man3"), #imageLiteral(resourceName: "man2"), #imageLiteral(resourceName: "man1"), UIImage()]
    
    
    var wordToGuess = ""
    var chancesLeft = 7
    var wordArray = [String]()
    var wordArrayString = ""
    var underscoreArray = [String]()
    var underscoreArrayString = ""
    var letter = ""
    var enteredLetters = [String]()
    
    var capitalizedAlphabet: [String] {
        var newArray = [String]()
        for i in alphabet {
            newArray.append(i.uppercased())
        }
        return newArray
    }
    
    
    
    
    private func arrayToSpaceString(array: [String]) -> String {
        var string = ""
        for i in 0..<array.count {
            string += array[i] + " "
        }
        string.removeLast()
        return string
    }
    
    func makeWordArrayString() {
        wordArrayString = arrayToSpaceString(array: wordArray)
    }
    
    func makeUnderscoreArrayString() {
        underscoreArrayString = arrayToSpaceString(array: underscoreArray)
    }
    
    private func wordToArray(word: String) -> [String] {
        var stringArray = [String]()
        for i in word {
            stringArray.append(String(i))
        }
        return stringArray
    }
    
    func makeWordArray() {
        wordArray = wordToArray(word: wordToGuess)
    }
    
    private func wordArrayToUnderscore(wordArray: [String]) -> [String] {
        var underscoreArray = [String]()
        for _ in 0..<wordArray.count {
            underscoreArray.append("_")
        }
        return underscoreArray
    }
    
    func makeUnderscoreArray() {
        underscoreArray = wordArrayToUnderscore(wordArray: wordArray)
    }
    
    private func addCorrectLetterToUnderscoreArray(wordArray: [String], underscoreArray: [String], letter: String) -> [String] {
        var underscoreArray = underscoreArray
        for i in 0..<wordArray.count {
            if wordArray[i] == letter {
                underscoreArray[i] = wordArray[i]
            }
        }
        return underscoreArray
    }
    
    func addLetterToUnderscoreArray() {
        underscoreArray = addCorrectLetterToUnderscoreArray(wordArray: wordArray, underscoreArray: underscoreArray, letter: letter)
    }
    
    func enterLetter(letter: String) {
        enteredLetters.append(letter)
    }
    
    func changeChancesLeft() {
        if !wordArray.contains(letter) {
            chancesLeft -= 1
        }
    }
    
    
    private func checkIfGameIsOver(wordArray: [String], underscoreArray: [String]) -> Bool {
        if self.chancesLeft == 0 || wordArray == underscoreArray {
            return true
        } else {
            return false
        }
    }
    
    func isGameOver() -> Bool {
        return checkIfGameIsOver(wordArray: wordArray, underscoreArray: underscoreArray)
    }
    
    
    func reset() {
        wordToGuess = ""
        chancesLeft = 7
        wordArray = [String]()
        underscoreArray = [String]()
        enteredLetters = [String]()
        letter = ""
    }

    
    
}
