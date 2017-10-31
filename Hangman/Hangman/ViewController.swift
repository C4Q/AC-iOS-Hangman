//viewController - Hangman

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var enterWord: UITextField!
	@IBOutlet weak var guessChar: UITextField!
	@IBOutlet weak var usedLetters: UITextView!
	@IBOutlet weak var correctLetters: UILabel!
	@IBOutlet weak var hangmanDisplay: UIImageView!
	@IBOutlet weak var winLoseDisplay: UILabel!
	@IBOutlet weak var correctWordDisplay: UILabel!
	
	@IBAction func restartGame(_ sender: UIButton) {
		model.resetModel()
		enterWord.isUserInteractionEnabled = true
		enterWord.text = ""
		guessChar.text = ""
		usedLetters.text = ""
		correctLetters.text = ""
		model.addWord("")
		hangmanDisplay.image = nil
		correctWordDisplay.isHidden = true
		winLoseDisplay.isHidden = true
		enterWord.becomeFirstResponder() //put cursor at
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		enterWord.delegate = self
		guessChar.delegate = self
		enterWord.becomeFirstResponder()
		guessChar.isUserInteractionEnabled = false
	}
	
	var model = HangmanModel()
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == enterWord {
			model.addWord(textField.text!.lowercased())
			correctLetters.text = model.placeholderString
			enterWord.isUserInteractionEnabled = false
			guessChar.isUserInteractionEnabled = true
			guessChar.becomeFirstResponder()
		}
		return true
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == enterWord {
			let allowedChars = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
			guard string.rangeOfCharacter(from: allowedChars as CharacterSet) != nil else {return false}
		}
		
		if textField == guessChar { //check for guessChar textfield
			let allowedChars = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
			guard string.rangeOfCharacter(from: allowedChars as CharacterSet) != nil else {return false}
			
			guard string.characters.count == 1 else { return true }//block more than one character
			guard !model.usedChars.contains(string) else { return true }
			textField.text = ""

			model.matching(guessLetter: Character(string.lowercased()))
			usedLetters.text = model.usedChars
			correctLetters.text = model.placeholderString

			switch model.wrongGuessCounter { //updating hangman
//			case 0: hangmanDisplay.image = nil
			case 1: hangmanDisplay.image = #imageLiteral(resourceName: "man1")
			case 2: hangmanDisplay.image = #imageLiteral(resourceName: "man2")
			case 3: hangmanDisplay.image = #imageLiteral(resourceName: "man3")
			case 4: hangmanDisplay.image = #imageLiteral(resourceName: "man4")
			case 5: hangmanDisplay.image = #imageLiteral(resourceName: "man5")
			case 6: hangmanDisplay.image = #imageLiteral(resourceName: "man6")
			case 7: hangmanDisplay.image = #imageLiteral(resourceName: "man7")
			default: break
			}//end Switch
			
			if model.gameOver {
				winLoseDisplay.text = model.winLose
				winLoseDisplay.isHidden = false
				correctWordDisplay.text = "The correct word was: \(model.wordString) "
				correctWordDisplay.isHidden = false
				enterWord.isUserInteractionEnabled = false
				guessChar.isUserInteractionEnabled = false
			}
		} //end if
		
		return true
	}
} //end class ViewController

