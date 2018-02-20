//
//  BJModel.swift
//  BlackJack
//
//  Created by Jing Li on 2/9/18.
//  Copyright © 2018 Jing Li. All rights reserved.
//

import Foundation
import UIKit

enum Suit: Int {
    case club = 0, spade, diamond, heart
    func simpleDescription() -> String{
        switch self {
        case .club:
            return "club"
        case .spade:
            return "spade"
        case .diamond:
            return "diamond"
        case .heart:
            return "heart"
        }
    }
    
}

class Card {
    var suit: Suit = .club
    var digit = 1
    var isFaceUp = true
    
    init(suit: Suit, digit: Int){
        self.suit = suit
        self.digit = digit
    }
    
    static func generateAPackOfCards() -> [Card]{
        var deckOfCard = [Card]()
        for i in 0..<4{
            for j in 1...13{
                deckOfCard.append(Card(suit: Suit(rawValue: i)!, digit: j))
                
            }
        }
        return deckOfCard
    }
    
    func getCardImage() -> UIImage? {
        if isFaceUp{
            return UIImage(named: "\(suit.simpleDescription())-\(digit).png")
        }else{
            return UIImage(named: "card-back.png")
        }
    }
    
    func isAce() -> Bool {
        return digit == 1 ? true : false
    }
    func isAFaceOrTen() -> Bool {
        return digit > 9 ? true : false
    }
}

enum BJGameStage: Int{
    case playerStage = 0
    case dealerStage, gameOverStage
}

extension Array{
    mutating func shuffle(){
        for i in 0...(self.count-1){
            let tmpInt =  i+1
            let j = Int(arc4random_uniform(UInt32(tmpInt)))
            let tmp = self[i]
            self[i] = self[j]
            self[j] = tmp
        }
    }
}

class BJGameModel{
    private var cards = [Card]()
    private var playerCards = [Card]()
    private var dealerCards = [Card]()
    private var isBlackJack : Bool = false
    private var threshold : Int = 0
    private var numDecks : Int = 1
    var gameStage : BJGameStage = .playerStage
    
    let maxPlayerCards = 5
    var didDealerWin = false
    
    init(){
        resetGame(numDecks: 1, threshold: 0)
    }
    
    func resetGame(numDecks: Int, threshold: Int){
        cards = [Card]()
        for _ in 0..<numDecks {
            cards.append(contentsOf: Card.generateAPackOfCards())
        }
        self.numDecks = numDecks
        self.threshold = threshold
        //shuffle
        cards.shuffle()
        playerCards = [Card]()
        dealerCards = [Card]()
        isBlackJack = false
        gameStage = .playerStage
    }
    
    func resetGameSameDeck() {
        playerCards = [Card]()
        dealerCards = [Card]()
        isBlackJack = false
        gameStage = .playerStage
    }
    
    func nextDealerCard() -> Card{
        let card = cards.removeFirst()
        dealerCards.append(card)
        return card
    }
    func nextPlayerCard() -> Card{
        let card = cards.removeFirst()
        playerCards.append(card)
        return card
    }
    
    func dealerCardAtIndex(i: Int) ->Card?{
        if i < dealerCards.count{
            return dealerCards[i]
        }else{
            return nil
        }
    }
    func playerCardAtIndex(i: Int) ->Card?{
        if i < playerCards.count{
            return playerCards[i]
        }else{
            return nil
        }
    }
    
    func isBelowThreshold() -> Bool {
        return cards.count <= threshold
    }
    
    func getRemainingCards() -> Int {
        return cards.count
    }
    
    func getCurrentGameSettings() -> (numDecks: Int, threshold: Int) {
        return (numDecks: numDecks, threshold: threshold)
    }
    
    func areCardsBust(_ curCards: [Card]) -> Bool{
        var lowestScore = 0
        for card in curCards{
            if card.isAce(){
                lowestScore += 1
            }else if card.isAFaceOrTen(){
                lowestScore += 10
            }else {
                lowestScore += card.digit
            }
        }
        return lowestScore > 21 ? true : false
    }
    func calculateBestScore(_ curCards: [Card]) -> Int {
        if areCardsBust(curCards) {
            return 0
        }
        var higestScore = 0
        for card in curCards{
            if card.isAce(){
                higestScore += 11
            }else if card.isAFaceOrTen(){
                higestScore += 10
            }else {
                higestScore += card.digit
            }
        }
        while higestScore > 21 {
            higestScore -= 10
        }
        return higestScore
    }
    
    func checkForBlackJack() -> Bool {
        if calculateBestScore(playerCards) == 21 {
            isBlackJack = true
            return true
        }
        return false
    }
    
    func notifyGameDidEnd(){
        NotificationCenter.default.post(name: Notification.Name(rawValue:"BJNotificationGameDidEnd"), object: self, userInfo: ["didDealerWin" : didDealerWin])
    }
    
    func updateGameStage()  {
        if (isBlackJack) {
            gameStage = .gameOverStage
            didDealerWin = false
            notifyGameDidEnd()
        }
        if gameStage == .playerStage{
            if areCardsBust(playerCards){
                gameStage = .gameOverStage
                didDealerWin = true
                //play again somehow
                notifyGameDidEnd()
                
            }else if playerCards.count == maxPlayerCards {
                gameStage = .dealerStage
            }
            
        }else if gameStage == .dealerStage{
            if areCardsBust(dealerCards){
                gameStage = .gameOverStage
                didDealerWin = false
                //play again somehow
                notifyGameDidEnd()
            }else if dealerCards.count == maxPlayerCards{
                gameStage = .gameOverStage
                calcualteWinner()
                //play again somehow
                notifyGameDidEnd()
            }else{
                let dealerScore = calculateBestScore(dealerCards)
                if dealerScore < 17 {
                    //do nothing, still dealer's turn
                }else{
                    let playerScore = calculateBestScore(playerCards)
                    if playerScore > dealerScore{
                        //do nothing
                    }else{
                        didDealerWin = true
                        gameStage = .gameOverStage
                        //play again somehow
                        notifyGameDidEnd()
                    }
                }
            }
            
        }else{
            calcualteWinner()
            notifyGameDidEnd()
        }
        
    }
    
    func calcualteWinner(){
        let dealerScore = calculateBestScore(dealerCards)
        let playerScore = calculateBestScore(playerCards)
        didDealerWin = dealerScore >= playerScore
    }
    
    
}
