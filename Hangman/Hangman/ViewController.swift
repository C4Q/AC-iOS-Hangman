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
    @IBOutlet weak var GuessedLetterLabel: UILabel!
    @IBOutlet weak var SuccessLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var DashedWordLabel: UILabel!
    @IBOutlet weak var PlayerTwoTextField: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBAction func MultiplayerButton(_ sender: Any) {
        setUpGame(for: NumberOfPlayers.two)
    }
    @IBAction func VsCompButton(_ sender: Any) {
        setUpGame(for: NumberOfPlayers.one)
    }
    
    func resetUI() {
//        WordLabel.text = hangmanBrain.currentStats.randWord?.word
        DashedWordLabel.text = hangmanBrain.currentStats.randWord?.dashedWord
        ScoreLabel.text = hangmanBrain.updateGuesses(shouldReset: true)
        GuessedLetterLabel.isHidden = false
        
        hangmanBrain.currentStats.guessedLetters = []
        GuessedLetterLabel.text = String(describing: hangmanBrain.guessedLetters)
        
        TextField.isEnabled = true
        TextField.text?.removeAll()
        
        self.view.backgroundColor = .white
        
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
        guard let string = textField.text else { return false }
        guard CharacterSet.lowercaseLetters.isSuperset(of: CharacterSet.init(charactersIn: string))  else {
            SuccessLabel.text = "\(string) not in a-z."
            return false
        }
        hangmanBrain.setGivenWord(word: string)
//        WordLabel.text = hangmanBrain.currentStats.randWord?.word
        DashedWordLabel.text = hangmanBrain.currentStats.randWord?.dashedWord
        textField.isHidden = true
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 12 {
            //No backspace, etc.
            guard let unicodeString = UnicodeScalar(string) else {
                SuccessLabel.text = "\(string) is funny!"
                return false
            }
            
            guard CharacterSet.lowercaseLetters.contains(unicodeString) else {
                SuccessLabel.text = "\(string) not in a-z."
                return false
            }
            
            guard !hangmanBrain.currentStats.guessedLetters.contains(string) else {
                SuccessLabel.text = "\(string) already chosen."
                return false
            }
            
            checkLetter(letter: string)
        }
        
        return true
    }
    
    func checkLetter(letter: String) {
        TextField.text?.removeAll()
        
        if (hangmanBrain.currentStats.randWord?.word.contains(letter))! {
            //Update dashed word
            DashedWordLabel.text = hangmanBrain.dashedWordUpdate(letter: letter)
        } else {
            //else update alraedy guessed letters and increment # of guessed letters.
            GuessedLetterLabel.text = hangmanBrain.updateGuessedLetters(letter: letter)
            ScoreLabel.text = hangmanBrain.updateGuesses(shouldReset: false)
            updateImage()
        }
        
        if hangmanBrain.currentStats.triesRemaining == 0 {
            endGame(thatWas: .lost(withStats: hangmanBrain.currentStats))
        }
        if hangmanBrain.currentStats.randWord?.dashedWord == hangmanBrain.currentStats.randWord?.word {
            endGame(thatWas: .won(withStats: hangmanBrain.currentStats))
        }
    }
    
    func setUpGame(for numOfPlayers: NumberOfPlayers) {
        switch  numOfPlayers {
        case .one:
            hangmanBrain.getRandomWord()
        case .two:
            PlayerTwoTextField.isHidden = false
        }
        resetUI()
    }
    
    func appLoadSetUp() {
        TextField.isEnabled = false
        PlayerTwoTextField.isHidden = true
        GuessedLetterLabel.isHidden = true
    }
    
    func endGame(thatWas state: GameState) {
        appLoadSetUp()
        switch state {
        case .won:
            self.view.backgroundColor = UIColor(hue:0.93, saturation:0.76, brightness:0.79, alpha:1.00)
        case .lost:
            self.view.backgroundColor = UIColor(hue:0.12, saturation:0.77, brightness:0.99, alpha:1.00)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

