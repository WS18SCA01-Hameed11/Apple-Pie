//
//  Game.swift
//  Apple Pie
//
//  Created by Hameed Abdullah on 12/25/18.
//  Copyright © 2018 Hameed Abdullah. All rights reserved.
//

import Foundation

//1***
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
   
   
   
    //6***
    var gussedLetters: [Character]
    
    //7***
    // this method receives a Character, adds it to the  gussedLetters collection, and updated incorrectMovesRemaining
    mutating func playerGussed(letter: Character) {
        gussedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    
    //***9
    //Create Revealed Word - a computed property
    //Using word and guessedLetters, you can now compute a version of the word that hides the missing letters. For example, if the word for the round is "buccaneer" and the user has guessed the letters "c", "e," "b," and "j," the player should see "b_cc__ee_" at the bottom of the screen.
    /*
     1.Begin with an empty string variable.
     2.Loop through each character of word.
     3.If the character is in guessedLetters, convert it to a string, then append the letter onto the variable.
     4.Otherwise, append _ onto the variable.
     */
    var formattedWord: String {
        var gussedWord = ""
        
        for letter in word {
            
            if gussedLetters.contains(letter) {
                gussedWord += "\(letter)"
                
            } else {
                gussedWord += "_"
            }
            
        }
        
        return gussedWord
    }
    
}
