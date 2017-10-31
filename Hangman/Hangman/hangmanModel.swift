//
//  hangmanModel.swift
//  Hangman
//
//  Created by C4Q on 10/29/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

struct Player {
    var numPlayer: Int = 1
    var category: (SettingLevel?,SettingCategory?, [String]?) = (nil,nil,nil)
    var guessWord: String = ""
    var guessWordHidden: String {
        var letters = ""
        for _ in guessWord {
            letters.append("_ ")
        }
        return letters
    }
    var letterAlreadyTyped = ""
    var setGameLevel: SettingLevel = .easy
    var setGameCategory: SettingCategory = .animals
    var wrongAttempts = 0
    var matchAttempts = 0
}

enum SettingLevel {
    case easy
    case normal
    case hard
}

enum SettingCategory {
    case animals
    case tech
    case names
}

enum StatusGame {
    case win
    case lost
    case progress
}

class HangmanLogic {
    var currentPlayer = Player()
    private var wordByLevelandCat = [("easy","animals",["cat","dog","pig","rat",
                                                "ant","cow","bat","bee",
                                                "fly","bug","hog","fox",
                                                "emu","owl","boa","doe"]),
                             ("easy","tech",["Boot","Beta","Blog","Byte",
                                             "Cell","Chip","Clip","Code",
                                             "Copy","Core","Data","Dbms",
                                             "Dell","Disc","Disk","Dump",
                                             "Ebay","Edit","File","Flop",
                                             "Font","Form","Gate","Goto",
                                             "Hack","Hash","Heap","Help",
                                             "Home","Host","HTML","HTTP",
                                             "Icon","Imac","iPod","Java",
                                             "Jpeg","Link","Lisp","Load"]),
                             ("easy","names",["Vic","May","Rose","Zaka"]),
                             ("normal","animals",["Tiger","Vison","Zebra",
                                                  "Whale","Whelp","Tapir",
                                                  "Stoat","Spado","Skunk",
                                                  "Shrew","Shote","Shoat",
                                                  "Sheep","Serow","Sasin",
                                                  "Rhino","Phoca","Panda"]),
                             ("normal","tech",["Access","Analog","Avatar",
                                               "Backup","Banner","Binary",
                                               "Bitmap","Bitnet","Branch",
                                               "Bridge","Browse","Client",
                                               "Cursor","Decode","Defrag",
                                               "Delete","Dialup","Domain",
                                               "Dongle","Driver","Duplex",
                                               "Editor","Escape","Export",
                                               "Filter","Floppy","Folder",
                                               "Format","Google","Gopher",
                                               "Hacker","Header","Import",
                                               "Inkjet","Itunes","Keypad"]),
                             ("normal","names",["George","Roger","Isaac","Ismael"]),
                             ("hard","animals",["Aardvark","Antelope",
                                                "Babirusa","Behemoth",
                                                "Bontebok","Bullcalf",
                                                "Bushbuck","Cachalot",
                                                "Capuchin","Capybara",
                                                "Carcajou","Cetacean",
                                                "Chigetai","Chinkara",
                                                "Cricetid","Elephant",
                                                "Hoggerel","Hylobate",
                                                "Kangaroo","Lamantin",
                                                "Mandrill","Mastodon",
                                                "Mongoose","Musquash",
                                                "Pangolin","Porkling"]),
                             ("hard","tech",["Bookmark","Compiler",
                                             "Database","Diskette",
                                             "Document","Download",
                                             "Downtime","Ethernet",
                                             "Explorer","Firewall",
                                             "Firmware","Freeware",
                                             "Gigabyte","Graphics",
                                             "Halfword","Hardware",
                                             "Hardwire","Internet",
                                             "Intranet","Joystick",
                                             "Keyboard","Kilobyte",
                                             "Language","Linefeed",
                                             "Megabyte","Metadata",
                                             "Navigate","Netscape",
                                             "Password","Quadword",
                                             "Redirect","Register"]),
                             ("hard","names",["Armando","Karelia","Marlon","Napoleon"])]
    func getSecretGuessWord() -> String {
        var secretWord = ""
        for category in wordByLevelandCat {
            if category.0.uppercased() == String(describing: currentPlayer.setGameLevel).uppercased() && category.1.uppercased() == String(describing: currentPlayer.setGameCategory).uppercased() {
                secretWord = category.2[Int(arc4random_uniform(UInt32(category.2.count - 1)))].uppercased()
            }
        }
        return secretWord
    }
    
    func isMatch(_ chr: Character) -> Bool {
        for letter in currentPlayer.guessWord {
            if chr == letter {
                currentPlayer.matchAttempts += 1
                return true
            }
        }
        currentPlayer.wrongAttempts += 1
        return false
    }
    
    func isWinner() -> StatusGame {
        if currentPlayer.guessWord.count == currentPlayer.matchAttempts {
            return .win
        }
        if currentPlayer.wrongAttempts == 7 {
            return .lost
        }
        return .progress
    }
    
    func getRevealLetter() -> String {
        var word = ""
        for letter in currentPlayer.guessWord {
            if currentPlayer.letterAlreadyTyped.contains(letter) {
                word.append(String(letter)+" ")
                continue
            }
            word.append("_ ")
        }
        return word
    }
}
