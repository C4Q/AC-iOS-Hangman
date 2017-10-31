//  HangmanModel.swift

import Foundation
import UIKit

class HangmanModel {
	var wordString: String = ""
	var placeholderArray = [Character]()
	var placeholderString = ""
	var usedChars: String = ""
	var wrongGuessCounter: Int = 0
	var gameOver = false
	var winLose = ""
	
	func resetModel() {
		wordString = ""
		placeholderArray = []
		usedChars = ""
		wrongGuessCounter = 0
		winLose = ""
		gameOver = false
	}
	
	func newWord(_ word: String) {
		self.wordString = word
		self.placeholderArray = Array(repeating: ".", count: word.count)
		self.placeholderString = String(placeholderArray)
	}
	
	func matching(guessLetter: Character) {
		guard !usedChars.contains(guessLetter) else {return} //guard repeated characters
		usedChars.append(guessLetter) //add letter to usedChars
		
		if wordString.contains(guessLetter) {
			for (index, value) in wordString.enumerated(){ //iterate through each character in string word
				if guessLetter == value {//user guessed character matches in word
					self.placeholderArray[index] = value //update placeholder _ with the letter
				}
			}
			self.placeholderString = String(self.placeholderArray) //assign to string
			if self.placeholderString == self.wordString {
				winLose = "You Win!"
				gameOver = true
			}
		} else { //letter does not match in word
			self.wrongGuessCounter += 1
			if self.wrongGuessCounter == 7 {
				winLose = "You Lose"
				gameOver = true } //if wrong guesses exhausted then end game
		}
	}
}
	
	
	



