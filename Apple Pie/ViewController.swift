//
//  ViewController.swift
//  Apple Pie
//
//  Created by Hameed Abdullah on 12/23/18.
//  Copyright © 2018 Hameed Abdullah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButton: [UIButton]!
    
    var listOfWords: [String] = [
        "buccaneer",
        "swift",
        "glorious",
        "incandescent",
        "bug",
        "program"
    ]
    
    //2***
    //how many incorrect guesses are allowed per round
    let incorrectMovesAllowed: Int = 7
    
//    var totalWins = 0
//    var totalLosses = 0
    
    //13***
    // Whenever totalWins or totalLosses changes, a new round can be started, so this is a great time to add didSet property observers to totalWins and totalLosses.
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var score: Int = 0 {
        didSet {
            newRound()
        }
    }
//    var score: Int = 0
    
    //a property that holds the current game's value so that it can be updated throughout the view controller code
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
        
        
    }
    
    //3***
      //QUESTION: why do we say removeFirst()
    func newRound() {
        
      /*  //give the Game a new word in the initializer by removing the first value from the listOfWords collection
        let newWord = listOfWords.removeFirst() // do we use subsript here?
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, gussedLetters: [])
        
        updateUI()
       */
        
        
        //Re-enable Buttons and Fix Crash
        // if listOfWords isn't empty, then you should perform the same work that you did previously, but also re-enable all of the buttons. If there are no more words to play with, disable all of the buttons so that the player cannot continue playing the game.
        if !listOfWords.isEmpty {
            
            let newWord = listOfWords.removeFirst()
    
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, gussedLetters: [Character]())
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
        
        
    }
    
    //Called by newRound.
    //The enableLetterButtons(_:) method is fairly straightforward. It takes a Bool as an argument, and it uses the parameter to enable or disable the collection of buttons by looping through them.
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButton {
            button.isEnabled = enable
        }
    }

    
    //5***
    // Extract Button Title
    // Whenever a button is clicked, you should read the button's title, and determine if that letter is in the word the player is trying to guess. Begin by reading the title that's used when the button is in its "normal" state.
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //a player can't select a letter more than once in the same round
        sender.isEnabled = false
        
        let letterString = sender.title(for: .normal)!
        
        //convert it from a String to a Character.
        let letter = Character(letterString.lowercased())
        
        //8***
        currentGame.playerGussed(letter: letter)
        print("currentGame: \(currentGame!)")
        
        
        //updateUI()
        
        //13***
        updateGameState()
    }
    
    
    //4***
    func updateUI() {
        
        //11***
        //Start by converting the array of characters in formattedWord into an array of strings. Use a for loop to store each of the newly-created strings into a [String] array. Then you can call the joined(separator:) method to join the new collection together, separated by blank spaces

        var letters: [String] = [String]()
        letters = currentGame.formattedWord.map { String($0)} // by Using map
        
       
        /* //by Using For Loop
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }*/
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
      
        
        
        
//        //10***
//        //formattedWord is a property that UI can display, use it for the text of currentWordLabel
//        correctWordLabel.text = currentGame.formattedWord
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses), Score: \(score)"
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    //12***
    // Handle a Win or Loss
    // A game is lost if incorrectMovesRemaining reaches 0. When it does, increment totalLosses. You can determine that a game has been won if the player has not yet lost, and if the current game's word property is equal to the formattedWord (formattedWord won't have any underscore if every letter has been successfully guessed). When that happens, increment totalWins. If a game has not been won or lost yet, then the player should be allowed to continue guessing, and the interface should be updated.
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            score += 10
        } else {
            updateUI()
        }
    }
}

