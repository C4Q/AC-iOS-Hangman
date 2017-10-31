//
//  ViewController.swift
//  Hangman
//
//  Created by Marcel Chaucer on 10/18/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {
    
    let hangmanBrain = HangmanBrain()
    var delegate: UITextFieldDelegate?
    
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var WordLabel: UILabel!

    @IBOutlet weak var SuccessLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var DashedWordLabel: UILabel!
    @IBOutlet weak var PlayerTwoTextField: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var WinLabel: UILabel!
    @IBAction func MultiplayerButton(_ sender: Any) {
        setUpGame(for: NumberOfPlayers.two)
    }
    @IBAction func VsCompButton(_ sender: Any) {
        setUpGame(for: NumberOfPlayers.one)
    }
    
    func setUpGame(for numOfPlayers: NumberOfPlayers) {
        self.view.backgroundColor = UIColor(hue:0.17, saturation:0.01, brightness:0.78, alpha:1.00)
        switch  numOfPlayers {
        case .one:
            hangmanBrain.getRandomWord()
            PlayerTwoTextField.isHidden = true
             resetUI()
        case .two:
            DashedWordLabel.isHidden = true
            PlayerTwoTextField.isHidden = false
            DashedWordLabel.text = "Try me! Enter a word."
             resetUI()
            TextField.isEnabled = false
        }
       
    }
    
    func resetUI() {
        
        DashedWordLabel.text = hangmanBrain.currentStats.randWord?.dashedWord
        ScoreLabel.text = hangmanBrain.updateGuesses(shouldReset: true)
        
        //        GuessedLetterLabel.isHidden = false
        //        GuessedLetterLabel.text = String(describing: hangmanBrain.currentStats.guessedLetters)
        WinLabel.isHidden = true
        WinLabel.text?.removeAll()
        
        hangmanBrain.currentStats.guessedLetters = []
        SuccessLabel.text?.removeAll()
        
        TextField.isEnabled = true
        TextField.text?.removeAll()
        
        ImageView.image = nil
    }
    
    func updateImage() {
        switch hangmanBrain.currentStats.numOfGuess {
        case 1:
            ImageView.image = #imageLiteral(resourceName: "man1")
        case 2:
            ImageView.image = #imageLiteral(resourceName: "man2")
        case 3:
            ImageView.image = #imageLiteral(resourceName: "man3")
        case 4:
            ImageView.image = #imageLiteral(resourceName: "man4")
        case 5:
            ImageView.image = #imageLiteral(resourceName: "man5")
        case 6:
            ImageView.image = #imageLiteral(resourceName: "man6")
        case 7:
            ImageView.image = #imageLiteral(resourceName: "man7")
        default:
            ImageView.image = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == PlayerTwoTextField else { return false }
        guard let string = textField.text else { return false }
        guard !string.isEmpty else { return false }
        guard CharacterSet.lowercaseLetters.isSuperset(of: CharacterSet.init(charactersIn: string))  else {
            SuccessLabel.text = "\(string) not in a-z."
            return false
        }
        TextField.isEnabled = true
        hangmanBrain.setGivenWord(word: string)
        //        WordLabel.text = hangmanBrain.currentStats.randWord?.word
        DashedWordLabel.text = hangmanBrain.currentStats.randWord?.dashedWord
        DashedWordLabel.isHidden = false
        textField.isHidden = true
        textField.text?.removeAll()
        SuccessLabel.text?.removeAll()
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == TextField {
            return checkLetter(letter: string)
        }
        
        return true
    }
    
    func checkLetter(letter: String) -> Bool {
        
        //No backspace, etc.
        guard let unicodeString = UnicodeScalar(letter) else {
            SuccessLabel.text = "\(letter) No deleting!"
            return false
        }
        
        guard CharacterSet.lowercaseLetters.contains(unicodeString) else {
            SuccessLabel.text = "\(letter) not in a-z."
            return false
        }
        
        guard !(TextField.text?.contains(letter))! else {
            SuccessLabel.text = "\(letter) already chosen."
            return false
        }
        
        if (hangmanBrain.currentStats.randWord?.word.contains(letter))! {
            //Update dashed word
            DashedWordLabel.text = hangmanBrain.dashedWordUpdate(letter: letter)
        } else {
            //else update alraedy guessed letters and increment # of guessed letters.
            
            //            GuessedLetterLabel.text = hangmanBrain.updateGuessedLetters(letter: letter)
            
            ScoreLabel.text = hangmanBrain.updateGuesses(shouldReset: false)
            updateImage()
        }
        
        if hangmanBrain.currentStats.triesRemaining == 0 {
            endGame(thatWas: .lost(withStats: hangmanBrain.currentStats))
        }
        if hangmanBrain.currentStats.randWord?.dashedWord == hangmanBrain.currentStats.randWord?.word {
            endGame(thatWas: .won(withStats: hangmanBrain.currentStats))
        }
        
        return true
    }
    
    
    
    func appLoadSetUp() {
        SuccessLabel.text?.removeAll()
        TextField.text?.removeAll()
        TextField.isEnabled = false
        PlayerTwoTextField.isHidden = true
        self.view.backgroundColor = UIColor(hue:0.17, saturation:0.01, brightness:0.78, alpha:1.00)
    }
    
    func endGame(thatWas state: GameState) {
        appLoadSetUp()
        DashedWordLabel.text = hangmanBrain.currentStats.randWord?.word
        WinLabel.isHidden = false
        switch state {
        case .won:
            self.view.backgroundColor = UIColor(hue:0.55, saturation:0.62, brightness:0.96, alpha:1.00)
            WinLabel.text = "You win!"
        case .lost:
            self.view.backgroundColor = UIColor(hue:0.12, saturation:0.77, brightness:0.99, alpha:1.00)
            WinLabel.text = "You lose! Word was *\(String(describing: (hangmanBrain.currentStats.randWord?.word)!))*"

        default:
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.TextField.delegate = self
        self.PlayerTwoTextField.delegate = self
        appLoadSetUp()
        WinLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

