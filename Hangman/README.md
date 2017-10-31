# AC-iOS-Hangman

You have built hangman for a command line app before.  Now it's time to build it as an iOS project.

[Here is the game online](http://www.playhangman.com/PH.asp?g=SCRABBLE7) if you need a refresher.

## Rules

- The user sees a label with one "_" for each letter in the word
- The user will enter letters one at a time
- If the user guesses a correct letter, all instances of that word are made visible in the label
- If the user guesses an incorrect letter, the hangman gets one body part added
- The user wins when all the correct letters are revealed and they see the full word
- The user loses when they have made 7 incorrect guesses and the full hangman is visible

## Project Requirements

- This will be a two player game
- The first player will enter a word in a secure textfield (password style) to enter the word for the game
- The second player then enters their guesses one letter at a time in a separate text field
- The user must enter each letter through a text field
- Whenever the user types in a new letter, that counts as a guess
- If the user guesses incorrectly, the image should change to the appropriate hangman image
- If the user guesses correctly, the label visible to the user should update appropriately
- The user should not be able to type in anything except for the letters a-z
- The user should not be able to type in a letter that they have already guessed
- The user should not be able to delete letters
- When the game ends, the text field clears and the user can choose to start a new game

## Bonuses

- Implement a single player version that selects a word at random from a given list
- For single player, allow the user to select a category from which a word will be chosen at random
- Allow the user to select what images the hangman displays as