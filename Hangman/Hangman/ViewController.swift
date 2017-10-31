//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var instruLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var twoPlayersButton: UIButton!
    @IBOutlet weak var onePlayerButton: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textFieldTwo.delegate = self
        setUpGame()
    }
    
    @IBAction func playerButtonPressed(_ sender: UIButton) {
        model.selectNumOfPlayers(num: sender.tag)
        if sender.tag == 1 {
            
             model.setUpGameForOne()
            
            button3.isHidden = false
            button4.isHidden = false
            imageView.isHidden = true
            instruLabel.text = "Please select a hangman image:"
            button3.setImage(#imageLiteral(resourceName: "man7"), for: .normal)
            button4.setImage(#imageLiteral(resourceName: "oneman6"), for: .normal)
        }
        if sender.tag == 2 {
             model.setUpGameForTwo()
            self.setUpTwoPlayerGame()
        }
        onePlayerButton.isHidden = true
        twoPlayersButton.isHidden = true
    }
    
    @IBAction func buttonImagePressed(_ sender: UIButton) {
        model.imageSelected(num: sender.tag)
        setUpOnePlayerGame()
       
        imageView.image = #imageLiteral(resourceName: "hungman")
        button3.isHidden = true
        button4.isHidden = true
        imageView.isHidden = false
        labelTwo.isHidden = false
        labelTwo.text = "Enter One letter each time"
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        switch model.numberOfPlayers {
        case 2:
        model.setUpGameForTwo()
        setUpTwoPlayerGame()
        default :
        model.setUpGameForOne()
        setUpOnePlayerGame()
        }
        textFieldTwo.isEnabled = true
        imageView.image = #imageLiteral(resourceName: "hungman")
    }
    
    
    var model = HangmanBrain()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if textField == self.textField {
            guard let text = textField.text else {
                return false
            }
            guard text.count != 0 else {
                return false
            }
            print(text)
        model.getWord(str: text)
        instruLabel.text = model.underScore
        textField.resignFirstResponder()
        self.textField.isHidden = true
        self.textFieldTwo.isHidden = false
        self.labelTwo.isHidden = false
        self.labelTwo.text = "Player Two: enter One letter each time"
           
        return true
        } else {
            guard let text = textField.text else {
                return false
            }
            guard text.count != 0 else {
                 self.labelTwo.text = "Please enter One letter of 'a-z' "
                return false
            }
            if model.ifCorrectGuess(str: text) {
                instruLabel.text = model.underScore
                self.labelTwo.text = "\(text) is correct"
                if model.checkIfWin() {
                    switch model.numberOfPlayers {
                    case 2:
                    self.labelTwo.text = "correct guesses! Player two Wins!"
                    default:
                      self.labelTwo.text = "correct guesses! You Wins!"
                    }
                    labelTwo.backgroundColor = .green
                    newGameButton.isHidden = false
                    textFieldTwo.isEnabled = false
                    imageView.image = #imageLiteral(resourceName: "hungman")
                }
            } else {
                if model.image == .setOne {
                switch model.wrongGuess {
                case 1:
                     imageView.image = #imageLiteral(resourceName: "man1")
                    labelTwo.text = "'\(text)' is wrong guess"
                case 2:
                    imageView.image = #imageLiteral(resourceName: "man2")
                    labelTwo.text = "'\(text)' is wrong guess"
                case 3:
                    imageView.image = #imageLiteral(resourceName: "man3")
                    labelTwo.text = "'\(text)' is wrong guess"
                case 4:
                    imageView.image = #imageLiteral(resourceName: "man4")
                    labelTwo.text = "'\(text)' is wrong guess"
                case 5:
                    imageView.image = #imageLiteral(resourceName: "man5")
                    labelTwo.text = "'\(text)' is wrong guess"
                case 6:
                    imageView.image = #imageLiteral(resourceName: "man6")
                    labelTwo.text = "'\(text)' is wrong guess"
                default:
                    imageView.image = #imageLiteral(resourceName: "man7")
                    switch model.numberOfPlayers {
                    case 2:
                    labelTwo.text = "Player two have been hung"
                    default:
                   labelTwo.text = "You have been hung"
                    }
                    labelTwo.backgroundColor = .red
                     instruLabel.text = model.word
                    textFieldTwo.isEnabled = false
                    newGameButton.isHidden = false
                }
                }
                if model.image == .setTwo {
                    switch model.wrongGuess {
                    case 1:
                        imageView.image = #imageLiteral(resourceName: "oneman0")
                        labelTwo.text = "'\(text)' is wrong guess"
                    case 2:
                        imageView.image = #imageLiteral(resourceName: "oneman1")
                        labelTwo.text = "'\(text)' is wrong guess"
                    case 3:
                        imageView.image = #imageLiteral(resourceName: "oneman2")
                        labelTwo.text = "'\(text)' is wrong guess"
                    case 4:
                        imageView.image = #imageLiteral(resourceName: "oneman3")
                        labelTwo.text = "'\(text)' is wrong guess"
                    case 5:
                        imageView.image = #imageLiteral(resourceName: "oneman4")
                        labelTwo.text = "'\(text)' is wrong guess"
                    case 6:
                        imageView.image = #imageLiteral(resourceName: "oneman5")
                        labelTwo.text = "'\(text)' is wrong guess"
                    default:
                        imageView.image = #imageLiteral(resourceName: "oneman6")
                        labelTwo.text = "You have been hung"
                        labelTwo.backgroundColor = .red
                        instruLabel.text = model.word
                        textFieldTwo.isEnabled = false
                        newGameButton.isHidden = false
                    }
                }
               
            }
            textField.resignFirstResponder()
           // textFieldShouldEndEditing(textFieldTwo)
           // textFieldShouldClear(textFieldTwo)
            return true
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = nil
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        //if textField == self.textField {
           //print(string)
           // print(range.upperBound,range.upperBound, string)
        if textField == self.textField {
            if string == "" {
                return true
            }
        }
            guard model.alphabet.contains(string.lowercased()) else {
                self.labelTwo.text = "invalid input ' \(string) ', enter letter 'a-z'"
                return false
            }
               // return true
        if textField == textFieldTwo {
            if string == "" {
                return false
            }
            guard range.upperBound < 1 else {
                self.labelTwo.text = "Please enter One letter of 'a-z' "
                return false
            }
            if model.ifAlreadyGuessed(str: string) {
                self.labelTwo.text = "\(string) already guessed"
                return false
            }
        }
        return true
    }
   
    func setUpTwoPlayerGame() {
        textField.isHidden = false
        textFieldTwo.isHidden = true
        labelTwo.isHidden = true
        textFieldShouldClear(textField)
        textFieldShouldClear(textFieldTwo)
        newGameButton.isHidden = true
        self.instruLabel.text = "Player One: Please enter a word below"
        self.instruLabel.backgroundColor = .white
        self.labelTwo.backgroundColor = .white
        onePlayerButton.isHidden = true
        twoPlayersButton.isHidden = true
    }
    func setUpGame() {
        instruLabel.text = "Please select game"
        onePlayerButton.isEnabled = true
        twoPlayersButton.isEnabled = true
        textField.isHidden = true
         newGameButton.isHidden = true
        imageView.image = #imageLiteral(resourceName: "hungman")
        textFieldTwo.isHidden = true
        labelTwo.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
    }
    func setUpOnePlayerGame() {
        onePlayerButton.isHidden = true
        twoPlayersButton.isHidden = true
         newGameButton.isHidden = true
       instruLabel.text = model.underScore
       self.textField.isHidden = true
        textFieldTwo.isHidden = false
        labelTwo.text = "Enter One letter each time"
        labelTwo.backgroundColor = .white
    }
    
}

