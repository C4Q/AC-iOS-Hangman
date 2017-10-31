//
//  HangMan.swift
//  Hangman
//
//  Created by Clint Mejia on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

enum GameMode: String{
    case randomWord = "1 player mode."
    case wordChosen = "2 player mode."
}

class Hangman {
    
    enum GameStatus: String {
        case onGoing = "Please enter a letter."
        case failed = "Fail!"
        case victorious = "Victory!"
        case enterMysteryWord = "Please enter a secret word."
    }
    
    struct GameRules {
        var currentTotalAttempts: Int = 0
        var maxAttempts: Int = 7
        var potentialLetters = "abcdefghijklmnopqrstuvwxyz"
    }
    
    var gameRules = GameRules()
    var randomWord = WordBank(word: "")
    var hangmanImage: String = ""
    var currentGameMode = GameMode.randomWord
    var gameStatus: GameStatus = .enterMysteryWord
    var mysterWordInProgress: [String] = []
    var potentialLetters: [String] = []
    
    init() {
        startNewGame()
    }
    

    private func startNewGame(){
        potentialLetters = gameRules.potentialLetters.characters.map{ String($0)}
        gameRules.currentTotalAttempts = 0
        currentGameMode = .randomWord
        gameStatus = .enterMysteryWord
        hangmanImage = getHangmanImage()
    }
    
    
    func setMysteryWord(as thisWord: String) {
        randomWord = WordBank.init(word: thisWord)
        mysterWordInProgress = Array(repeatElement("_ ", count: thisWord.count))
        currentGameMode = .wordChosen
        gameStatus = .onGoing
        return
    }
    
    
    func checkInputForValid(string: String) -> Bool {
        guard currentGameMode != .randomWord else {
            setMysteryWord(as: string)
            return true
        }
        guard potentialLetters.contains(string) && randomWord.word.contains(string) else {
            gameRules.currentTotalAttempts += 1
            potentialLetters = potentialLetters.filter{$0 != string}
            hangmanImage = getHangmanImage()
            gameOverChecker()
            return true
        }
        populateMysteryWord(with: string)
        potentialLetters = potentialLetters.filter{$0 != string}
        gameOverChecker()
        return true
    }
    
    func getHangmanImage() -> String {
        switch gameRules.currentTotalAttempts {
        case 0:
            hangmanImage = "classico.png"
        case 1:
            hangmanImage = "classico1.png"
        case 2:
            hangmanImage = "classico2.png"
        case 3:
            hangmanImage = "classico3.png"
        case 4:
            hangmanImage = "classico4.png"
        case 5:
            hangmanImage = "classico5.png"
        case 6:
            hangmanImage = "classico6.png"
        case 7:
            hangmanImage = "classico7.png"
        default:
            break
        }
        return hangmanImage
    }
    
    
    func populateMysteryWord(with letter: String) {
        for index in 0..<randomWord.wordAsArray.count where randomWord.wordAsArray[index] == letter {
            mysterWordInProgress[index] = letter
        }
    }
    
    func gameOverChecker(){
        guard gameRules.currentTotalAttempts != gameRules.maxAttempts else {
            return gameStatus = .failed
        }
        guard randomWord.word == mysterWordInProgress.joined() else {
            return gameStatus = .onGoing
        }
        return gameStatus = .victorious
    }
}


