//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var buttons: [UIButton] = []
    var logicGame = HangmanLogic()
    @IBOutlet weak var lblPlayers: UILabel!
    @IBOutlet weak var vwSetting: UIView!
    @IBOutlet weak var txtSecretWord: UITextField!
    @IBOutlet weak var lblSecretWord: UILabel!
    @IBOutlet weak var levelEasy: UIButton!
    @IBOutlet weak var levelNormal: UIButton!
    @IBOutlet weak var levelHard: UIButton!
    @IBOutlet weak var catAnimals: UIButton!
    @IBOutlet weak var catTech: UIButton!
    @IBOutlet weak var catNames: UIButton!
    @IBOutlet weak var displayPlayer: UITextView!
    @IBOutlet weak var displayCategory: UITextView!
    @IBOutlet weak var switchPlayer: UISwitch!
    @IBOutlet weak var lblAlertUser: UILabel!
    @IBOutlet weak var txtInputUser: UITextField!
    @IBOutlet weak var imgHangman: UIImageView!
    @IBOutlet weak var btnStartGame: UIButton!
    
    @IBAction func swPlayers(_ sender: UISwitch) {
        if sender.isOn {
            lblPlayers.text = "One Player"
            txtSecretWord.isHidden = true
            txtSecretWord.text = ""
            displayPlayer.text = "Player \n\n One"
        } else {
            lblPlayers.text = "Two Players"
            txtSecretWord.isHidden = false
            displayPlayer.text = "Players \n\n Two"
            txtSecretWord.becomeFirstResponder()
        }
    }
    @IBAction func btnLevelGame(_ sender: UIButton) {
        displayCategory.text = "Categories \n"
        sender.isSelected = true
        switch sender.tag {
        case 1:
            levelNormal.isSelected = false
            levelHard.isSelected = false
            logicGame.currentPlayer.setGameLevel = .easy
        case 2:
            levelEasy.isSelected = false
            levelHard.isSelected = false
            logicGame.currentPlayer.setGameLevel = .normal
        case 3:
            levelEasy.isSelected = false
            levelNormal.isSelected = false
            logicGame.currentPlayer.setGameLevel = .hard
        default:
            break
        }
        for btn in buttons {
            if btn.isSelected {
                displayCategory.text.append("\n"); displayCategory.text.append(btn.currentTitle!)
            }
        }
    }
    
    @IBAction func btnCategoryGame(_ sender: UIButton) {
        displayCategory.text = "Categories \n"
        sender.isSelected = true
        switch sender.tag {
        case 1:
            catTech.isSelected = false
            catNames.isSelected = false
            logicGame.currentPlayer.setGameCategory = .animals
        case 2:
            catAnimals.isSelected = false
            catNames.isSelected = false
            logicGame.currentPlayer.setGameCategory = .tech
        case 3:
            catAnimals.isSelected = false
            catTech.isSelected = false
            logicGame.currentPlayer.setGameCategory = .names
        default:
            break
        }
        for btn in buttons {
            if btn.isSelected {
                displayCategory.text.append("\n"); displayCategory.text.append(btn.currentTitle!)
            }
        }
    }
    
    @IBAction func StartGame(_ sender: UIButton) {
        if btnStartGame.titleLabel?.text == "START" {
            btnStartGame.setTitle("RESET", for: .normal)
            startGame()
            txtInputUser.becomeFirstResponder()
        } else {
            btnStartGame.setTitle("START", for: .normal)
            resetGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSecretWord.delegate = self
        txtInputUser.delegate = self
        resetGame()
    }
    func resetGame() {
        buttons = [levelEasy,
                   levelNormal,
                   levelHard,
                   catAnimals,
                   catTech,
                   catNames]
        txtSecretWord.isHidden = true
        txtSecretWord.text = ""
        txtInputUser.text = ""
        imgHangman.image = nil
        vwSetting.isHidden = false
        switchPlayer.isOn = true
        lblPlayers.text = "One Player"
        displayCategory.text = "Categories \n"
        logicGame.currentPlayer.numPlayer = 1
        logicGame.currentPlayer.category = (nil,nil,nil)
        logicGame.currentPlayer.guessWord = ""
        logicGame.currentPlayer.letterAlreadyTyped = ""
        logicGame.currentPlayer.setGameLevel = .easy
        logicGame.currentPlayer.setGameCategory = .animals
        logicGame.currentPlayer.wrongAttempts = 0
        logicGame.currentPlayer.matchAttempts = 0
        lblAlertUser.text = ""
        levelEasy.isSelected = true
        levelNormal.isSelected = false
        levelHard.isSelected = false
        catAnimals.isSelected = true
        catTech.isSelected = false
        catNames.isSelected = false
        if switchPlayer.isOn {
            displayPlayer.text = "Players \n\n One"
        } else {
            displayPlayer.text = "Players \n\n Two"
        }
        for btn in buttons {
            if btn.isSelected {
                displayCategory.text.append("\n"); displayCategory.text.append(btn.currentTitle!)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if txtSecretWord == textField {
            if string == "" {
                return true
            }
            if "abcdefghijklmnopqrsuvwxyzt".contains(string.lowercased()) {
                return true
            } else {
                return false
            }
        }
        if let chr = string.uppercased().last {
            if logicGame.currentPlayer.letterAlreadyTyped.contains(chr) {
                lblAlertUser.text = "\"\(string.uppercased())\" has been typed."
            } else {
                logicGame.currentPlayer.letterAlreadyTyped.append(chr)
                lblAlertUser.text = logicGame.currentPlayer.letterAlreadyTyped
                if txtInputUser == textField {
                    if logicGame.isMatch(chr) {
                        lblSecretWord.text = logicGame.getRevealLetter()
                    } else {
                        wrongAttemptsImage()
                    }
                }
            }
            txtInputUser.text = ""
        }
        switch logicGame.isWinner() {
            case .win:
            lblAlertUser.text = "You Win"
            txtInputUser.isHidden = true
        case .lost:
            lblAlertUser.text = "LOST, Guess word: \(logicGame.currentPlayer.guessWord)"
            txtInputUser.isHidden = true
        case .progress:
            break
        }
        lblAlertUser.isHidden = false
        textField.resignFirstResponder()
        txtInputUser.becomeFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtSecretWord {
            if textField.text != "" {
                if btnStartGame.titleLabel?.text == "START" {
                    btnStartGame.setTitle("RESET", for: .normal)
                }
                startGame()
            } else {
                lblAlertUser.text = "Please set the secret word"
                lblAlertUser.isHidden = false
                return false
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func startGame() {
        if switchPlayer.isOn {
            txtInputUser.isHidden = false
            vwSetting.isHidden = true
            lblAlertUser.isHidden = true
            logicGame.currentPlayer.guessWord = logicGame.getSecretGuessWord()
            lblSecretWord.isHidden = false
        } else {
            if txtSecretWord.text == "" {
                lblAlertUser.text = "Please set the secret word"
                btnStartGame.setTitle("START", for: .normal)
                lblAlertUser.isHidden = false
            } else {
                txtInputUser.isHidden = false
                vwSetting.isHidden = true
                lblAlertUser.isHidden = true
                logicGame.currentPlayer.guessWord = txtSecretWord.text!.uppercased()
                lblSecretWord.isHidden = false
                txtInputUser.becomeFirstResponder()
            }
        }
        lblSecretWord.text = logicGame.currentPlayer.guessWordHidden
    }
    
    func wrongAttemptsImage() {
        switch logicGame.currentPlayer.wrongAttempts {
        case 1:
            imgHangman.image = #imageLiteral(resourceName: "man1")
        case 2:
            imgHangman.image = #imageLiteral(resourceName: "man2")
        case 3:
            imgHangman.image = #imageLiteral(resourceName: "man3")
        case 4:
            imgHangman.image = #imageLiteral(resourceName: "man4")
        case 5:
            imgHangman.image = #imageLiteral(resourceName: "man5")
        case 6:
            imgHangman.image = #imageLiteral(resourceName: "man6")
        case 7:
            imgHangman.image = #imageLiteral(resourceName: "man7")
        default:
            break
        }
        imgHangman.isHidden = false
    }
    
}

