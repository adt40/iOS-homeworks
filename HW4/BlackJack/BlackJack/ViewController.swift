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
    
    @IBOutlet weak var hitButton: UIButton!
    
    @IBOutlet weak var standButton: UIButton!
    
    @IBOutlet weak var numDecksTextField: UITextField!
    @IBOutlet weak var thresholdTextField: UITextField!
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
        card = gameModel.nextDealerCard()
        card.isFaceUp = false
        
        card = gameModel.nextPlayerCard()
        card = gameModel.nextPlayerCard()
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
            card = gameModel.nextDealerCard()
            card.isFaceUp = false
            
            card = gameModel.nextPlayerCard()
            card = gameModel.nextPlayerCard()
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
                dealersCards[i].image = dealerCard.getCardImage()
                dealersCards[i].isHidden = false
            }else{
                dealersCards[i].isHidden = true
            }
            if let playerCard = gameModel.playerCardAtIndex(i: i){
                playersCards[i].image = playerCard.getCardImage()
                playersCards[i].isHidden = false
            }else{
                playersCards[i].isHidden = true
            }
        }
        remainingCardsTextField.text = String(gameModel.getRemainingCards())
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
    }
    
    @IBAction func userClickStand(_ sender: UIButton) {
        //switch to dealer
        gameModel.gameStage = .dealerStage
        playDealerTurn()
        
    }
    
    @IBAction func userClickStart(_ sender: UIButton) {
        if let numDecks = Int(numDecksTextField.text!) {
            if let threshold = Int(thresholdTextField.text!) {
                restartGame(numDecks: numDecks, threshold: threshold)
            }
        }
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
                perform(aSelector, with: nil, afterDelay: 1)
            }
        }
    }
    
    @objc func showDealerNextCard(){
        gameModel.nextDealerCard()
        renderCards()
        gameModel.updateGameStage()
        if(gameModel.gameStage != .gameOverStage){
            //showDealerNextCard()
            let aSelector : Selector = #selector(BJViewController.showDealerNextCard)
            perform(aSelector, with: nil, afterDelay: 1)
        }
    }
    
}
