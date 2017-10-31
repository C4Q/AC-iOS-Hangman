//
//  Q1Brain.swift
//  TableViewExercises
//
//  Created by Masai Young on 10/30/17.
//  Copyright © 2017 Masai Young. All rights reserved.
//

import Foundation

class Q1Brain {
    
    var listOfContent = [Content]()
    
    struct Content {
        let emoji: Character
        let title: String
        let subtitle: String
    }
    
    
    
    private func appendContent(emoji: Character, title: String, subtitle: String) {
        let newLine = Content(emoji: emoji, title: title, subtitle: subtitle)
        listOfContent.append(newLine)
    }
    
    func setUpContent() {
        appendContent(emoji: "😀", title: "Grinning Face", subtitle: "A typical smiley face.")
        appendContent(emoji: "🤡", title: "Clown Face", subtitle: "Lead actor in the star film 'IT'.")
        appendContent(emoji: "🤠", title: "Cowboy Faec", subtitle: "McCree")
        appendContent(emoji: "🏀", title: "Basketball", subtitle: "Favorite Sport.")
        appendContent(emoji: "🤺", title: "Fencer", subtitle: "Did poorly in the class.")
        appendContent(emoji: "🤽🏾‍♂️", title: "Water Polo", subtitle: "Man playing water polo.")
        appendContent(emoji: "👮🏽‍♀️", title: "Police", subtitle: ".....")
        appendContent(emoji: "💈", title: "Barber Pole", subtitle: "Next destination...")
        appendContent(emoji: "🌚", title: "New Moon Face", subtitle: "Favorite emoji.")
        appendContent(emoji: "🐊", title: "Crocodile", subtitle: "Not an alligator.")
    }
    
    
}
