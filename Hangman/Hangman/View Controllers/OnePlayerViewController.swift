//
//  OnePlayerViewController.swift
//  Hangman
//
//  Created by C4Q on 10/28/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class OnePlayerViewController: UIViewController {

    var hangman = HangmanOnePlayerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hangman.newGame()
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIBarButtonItem) {
        hangman.newGame()
    }
    
}
