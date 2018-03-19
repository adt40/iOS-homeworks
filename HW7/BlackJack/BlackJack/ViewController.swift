//
//  ViewController.swift
//  BlackJack
//
//  Created by Jing Li on 2/9/18.
//  Copyright © 2018 Jing Li. All rights reserved.
//

import UIKit

class BJViewController: UIViewController {
    @IBOutlet var dealersCards: [UIImageView]!
    @IBOutlet var playersCards: [UIImageView]!
    
    private var gameModel: BJGameModel
    var numDecks = 1
    var threshold = 0
    
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var remainingCardsTextField: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        gameModel = BJGameModel()
        super.init(coder: aDecoder)
        let aSelector : Selector = #selector(BJViewController.handleNotificationGameDidEnd(_:))
        NotificationCenter.default.addObserver(self, selector: aSelector, name: NSNotification.Name(rawValue: "BJNotificationGameDidEnd"), object: gameModel)
    }
    
    @objc func handleNotificationGameDidEnd(_ notification: Notification){
        if let userInfo = notification.userInfo {
            if let dealerWin = userInfo["didDealerWin"]{
                let message = (dealerWin as! Bool) ? "Dealer Won" : "You Won"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Play again", style: .default, handler:({(_: UIAlertAction) -> Void  in self.restartGameSameDeck()}))
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func restartGame(numDecks: Int, threshold: Int){
        gameModel.resetGame(numDecks: numDecks, threshold: threshold)
        
        var card = gameModel.nextDealerCard()
        card.isFaceUp = true
        card = gameModel.nextDealerCard()
        
        card = gameModel.nextPlayerCard()
        card.isFaceUp = true
        card = gameModel.nextPlayerCard()
        card.isFaceUp = true
        renderCards()
        hitButton.isEnabled = true
        standButton.isEnabled = true
        if gameModel.checkForBlackJack() {
            gameModel.updateGameStage()
        }
    }
    
    func restartGameSameDeck() {
        if gameModel.isBelowThreshold() {
            let currentSettings = gameModel.getCurrentGameSettings()
            restartGame(numDecks: currentSettings.numDecks, threshold: currentSettings.threshold)
        } else {
            gameModel.resetGameSameDeck()
            var card = gameModel.nextDealerCard()
            card.isFaceUp = true
            card = gameModel.nextDealerCard()
            
            card = gameModel.nextPlayerCard()
            card.isFaceUp = true
            card = gameModel.nextPlayerCard()
            card.isFaceUp = true
            renderCards()
            hitButton.isEnabled = true
            standButton.isEnabled = true
            if gameModel.checkForBlackJack() {
                gameModel.updateGameStage()
            }
        }
    }
    
    func renderCards(){
        for i in 0 ..< gameModel.maxPlayerCards{
            if let dealerCard = gameModel.dealerCardAtIndex(i: i){
                if !dealerCard.wasFaceUp && dealerCard.isFaceUp {
                    animateFlip(card: dealerCard, cardView: dealersCards[i])
                } else {
                    dealersCards[i].image = dealerCard.getCardImage()
                    dealersCards[i].isHidden = false
                }
            }else{
                dealersCards[i].isHidden = true
            }
            if let playerCard = gameModel.playerCardAtIndex(i: i){
                if !playerCard.wasFaceUp && playerCard.isFaceUp {
                    animateFlip(card: playerCard, cardView: playersCards[i])
                } else {
                    playersCards[i].image = playerCard.getCardImage()
                    playersCards[i].isHidden = false
                }
            }else{
                playersCards[i].isHidden = true
            }
        }
        remainingCardsTextField.text = String(gameModel.getRemainingCards())
    }
    
    func animateFlip(card: Card, cardView: UIImageView) {
        let speed = 0.2
        let originalSize = cardView.bounds
        let shrunkSize = CGRect(x: originalSize.origin.x, y: originalSize.origin.y, width: 0, height: originalSize.height)
        UIView.animate(withDuration: speed, animations: {
            cardView.bounds = shrunkSize
        }, completion: { (tmp: Bool) -> () in
            cardView.image = card.getCardImage()
            UIView.animate(withDuration: speed, animations: {
                cardView.bounds = originalSize
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //restartGame()
    }
    
    @IBAction func userClickHit(_ sender: UIButton) {
        //deal a card to player and show it and do some calculation
        gameModel.nextPlayerCard()
        renderCards()
        gameModel.updateGameStage()
        perform(#selector(BJViewController.flipAllPlayerCards), with: nil, afterDelay: 0.1)
    }
    
    @objc func flipAllPlayerCards() {
        for i in 0 ..< gameModel.maxPlayerCards{
            if let playerCard = gameModel.playerCardAtIndex(i: i) {
                if !playersCards[i].isHidden {
                    playerCard.isFaceUp = true
                }
            }
        }
        renderCards()
    }
    
    @objc func flipAllDealerCards() {
        for i in 0..<gameModel.maxPlayerCards {
            if let dealerCard = gameModel.dealerCardAtIndex(i: i) {
                if !dealersCards[i].isHidden {
                    dealerCard.isFaceUp = true
                }
            }
        }
        renderCards()
    }
    
    @IBAction func userClickStand(_ sender: UIButton) {
        //switch to dealer
        gameModel.gameStage = .dealerStage
        playDealerTurn()
        
    }
    
    @IBAction func userClickStart(_ sender: UIButton) {
        restartGameSameDeck()
    }
    
    func playDealerTurn(){
        hitButton.isEnabled = false
        standButton.isEnabled = false
        showSecondDealerCard()
    }
    
    func showSecondDealerCard()  {
        if let card = gameModel.dealerCardAtIndex(i: 1){
            card.isFaceUp = true
            renderCards()
            gameModel.updateGameStage()
            //....
            if(gameModel.gameStage != .gameOverStage){
                //showDealerNextCard()
                let aSelector : Selector = #selector(BJViewController.showDealerNextCard)
                perform(aSelector, with: nil, afterDelay: 0.5)
            }
        }
    }
    
    @objc func showDealerNextCard(){
        gameModel.nextDealerCard()
        renderCards()
        perform(#selector(BJViewController.flipAllDealerCards), with: nil, afterDelay: 0.6)
        gameModel.updateGameStage()
        if(gameModel.gameStage != .gameOverStage){
            //showDealerNextCard()
            let aSelector : Selector = #selector(BJViewController.showDealerNextCard)
            perform(aSelector, with: nil, afterDelay: 0.5)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch (id) {
            case "Settings":
                let dvc = segue.destination as! SettingsViewController
                dvc.numDecks = numDecks
                dvc.threshold = threshold
            default: break
            }
        }
    }
    
    @IBAction func customUnwind( _ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? SettingsViewController {
            if let numDecksString = source.numDecksTextField.text {
                if let nd = Int(numDecksString) {
                    numDecks = nd
                }
            }
            if let thresholdString = source.thresholdTextField.text {
                if let t = Int(thresholdString) {
                    threshold = t
                }
            }
            
            restartGame(numDecks: numDecks, threshold: threshold)
        }
    }
}

