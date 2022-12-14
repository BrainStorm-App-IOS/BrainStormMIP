//
//  ViewController.swift
//  CardSlider
//
//  Created by Saoud Rizwan on 2/26/17.
//  Copyright © 2017 Saoud Rizwan. All rights reserved.
//

import UIKit
//import CardSlider

class SliderViewController: UIViewController {
    
    static var isNull: Bool  = true
    
    /// Data structure for custom cards - in this example, we're using an array of ImageCards
    var cards = [ImageCard]()
    /// The emojis on the sides are simply part of a view that sits ontop of everything else,
    /// but this overlay view is non-interactive so any touch events are passed on to the next receivers.
    var emojiOptionsOverlay: EmojiOptionsOverlay!
    var num = 0
    
    var game: GameModel
    var counter: Int
    
    init(game: GameModel, counter: Int) {
        self.game = game
        self.counter = counter
        
        if SliderViewController.isNull {
            for result in game.results {
                result.rating = 0
            }
        }
        
        SliderViewController.isNull = false
        game.stage = 4
        GameNetwork.refreshGameOnFirebase(game: game)
        
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.setHidesBackButton(true, animated: true)
        super.viewDidLoad()
        self.title = game.persons[game.persons.count - counter].name
        navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .systemBackground
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // 1. create a deck of cards
        // 20 cards for demonstrational purposes - once the cards run out, just re-run the project to start over
        // of course, you could always add new cards to self.cards and call layoutCards() again
        for index in 0..<game.results.count {
            print(index, game.results.count)
            let card = ImageCard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: self.view.frame.height * 0.7), info: (game.persons[index].name, game.results[index].problem!, game.results[index].solution!))
            cards.append(card)
            //ratingCards[card] = 0
        }
        
        // 2. layout the first 4 cards for the user
        layoutCards()
        
        // 3. set up the (non-interactive) emoji options overlay
        emojiOptionsOverlay = EmojiOptionsOverlay(frame: self.view.frame)
        self.view.addSubview(emojiOptionsOverlay)
    }
    
    /// Scale and alpha of successive cards visible to the user
    let cardAttributes: [(downscale: CGFloat, alpha: CGFloat)] = [(1, 1), (0.92, 0.8), (0.84, 0.6), (0.76, 0.4)]
    let cardInteritemSpacing: CGFloat = 15
    
    /// Set up the frames, alphas, and transforms of the first 4 cards on the screen
    func layoutCards() {
        // frontmost card (first card of the deck)
        let firstCard = cards[0]
        self.view.addSubview(firstCard)
        firstCard.layer.zPosition = CGFloat(cards.count)
        firstCard.center = self.view.center
        firstCard.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPan)))
        
        // the next 3 cards in the deck
        for i in 1...3 {
            if i > (cards.count - 1) { continue }
            
            let card = cards[i]
            
            card.layer.zPosition = CGFloat(cards.count - i)
            
            // here we're just getting some hand-picked vales from cardAttributes (an array of tuples)
            // which will tell us the attributes of each card in the 4 cards visible to the user
            let downscale = cardAttributes[i].downscale
            let alpha = cardAttributes[i].alpha
            card.transform = CGAffineTransform(scaleX: downscale, y: downscale)
            card.alpha = alpha
            
            // position each card so there's a set space (cardInteritemSpacing) between each card, to give it a fanned out look
            card.center.x = self.view.center.x
            card.frame.origin.y = cards[0].frame.origin.y - (CGFloat(i) * cardInteritemSpacing)
            // workaround: scale causes heights to skew so compensate for it with some tweaking
            if i == 3 {
                card.frame.origin.y += 1.5
            }
            
            self.view.addSubview(card)
        }
        
        // make sure that the first card in the deck is at the front
        self.view.bringSubviewToFront(cards[0])
    }
    
    /// This is called whenever the front card is swiped off the screen or is animating away from its initial position.
    /// showNextCard() just adds the next card to the 4 visible cards and animates each card to move forward.
    func showNextCard() {
        let animationDuration: TimeInterval = 0.2
        // 1. animate each card to move forward one by one
        for i in 1...3 {
            if i > (cards.count - 1) { continue }
            let card = cards[i]
            let newDownscale = cardAttributes[i - 1].downscale
            let newAlpha = cardAttributes[i - 1].alpha
            UIView.animate(withDuration: animationDuration, delay: (TimeInterval(i - 1) * (animationDuration / 2)), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                card.transform = CGAffineTransform(scaleX: newDownscale, y: newDownscale)
                card.alpha = newAlpha
                if i == 1 {
                    card.center = self.view.center
                } else {
                    card.center.x = self.view.center.x
                    card.frame.origin.y = self.cards[1].frame.origin.y - (CGFloat(i - 1) * self.cardInteritemSpacing)
                }
            }, completion: { (_) in
                if i == 1 {
                    card.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan)))
                }
            })
            
        }
        
        // 2. add a new card (now the 4th card in the deck) to the very back
        if 4 > (cards.count - 1) {
            if cards.count != 1 {
                self.view.bringSubviewToFront(cards[1])
            }
            return
        }
        let newCard = cards[4]
        newCard.layer.zPosition = CGFloat(cards.count - 4)
        let downscale = cardAttributes[3].downscale
        let alpha = cardAttributes[3].alpha
        
        // initial state of new card
        newCard.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        newCard.alpha = 0
        newCard.center.x = self.view.center.x
        newCard.frame.origin.y = cards[1].frame.origin.y - (4 * cardInteritemSpacing)
        self.view.addSubview(newCard)
        
        // animate to end state of new card
        UIView.animate(withDuration: animationDuration, delay: (3 * (animationDuration / 2)), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            newCard.transform = CGAffineTransform(scaleX: downscale, y: downscale)
            newCard.alpha = alpha
            newCard.center.x = self.view.center.x
            newCard.frame.origin.y = self.cards[1].frame.origin.y - (3 * self.cardInteritemSpacing) + 1.5
        }, completion: { (_) in
            
        })
        // first card needs to be in the front for proper interactivity
        self.view.bringSubviewToFront(self.cards[1])
        
    }
    
    /// Whenever the front card is off the screen, this method is called in order to remove the card from our data structure and from the view.
    func removeOldFrontCard() {
        cards[0].removeFromSuperview()
        cards.remove(at: 0)
    }
    
    /// UIKit dynamics variables that we need references to.
    var dynamicAnimator: UIDynamicAnimator!
    var cardAttachmentBehavior: UIAttachmentBehavior!
    
    /// This method handles the swiping gesture on each card and shows the appropriate emoji based on the card's center.
    @objc func handleCardPan(sender: UIPanGestureRecognizer) {
        // if we're in the process of hiding a card, don't let the user interace with the cards yet
        if cardIsHiding { return }
        // change this to your discretion - it represents how far the user must pan up or down to change the option
        let optionLength: CGFloat = 60
        // distance user must pan right or left to trigger an option
        let requiredOffsetFromCenter: CGFloat = 15
        
        let panLocationInView = sender.location(in: view)
        let panLocationInCard = sender.location(in: cards[0])
        switch sender.state {
        case .began:
            dynamicAnimator.removeAllBehaviors()
            let offset = UIOffset(horizontal: panLocationInCard.x - cards[0].bounds.midX, vertical: panLocationInCard.y - cards[0].bounds.midY);
            // card is attached to center
            cardAttachmentBehavior = UIAttachmentBehavior(item: cards[0], offsetFromCenter: offset, attachedToAnchor: panLocationInView)
            dynamicAnimator.addBehavior(cardAttachmentBehavior)
        case .changed:
            cardAttachmentBehavior.anchorPoint = panLocationInView
            if cards[0].center.x > (self.view.center.x + requiredOffsetFromCenter) {
                if cards[0].center.y < (self.view.center.y - optionLength) {
                    cards[0].showOptionLabel(option: .like1)
                    emojiOptionsOverlay.showEmoji(for: .like1)
                    
//                    if cards[0].center.y < (self.view.center.y - optionLength - optionLength) {
//                        emojiOptionsOverlay.updateHeartEmoji(isFilled: true, isFocused: true)
//                    } else {
//                        emojiOptionsOverlay.updateHeartEmoji(isFilled: true, isFocused: false)
//                    }
                    
                } else if cards[0].center.y > (self.view.center.y + optionLength) {
                    cards[0].showOptionLabel(option: .like3)
                    emojiOptionsOverlay.showEmoji(for: .like3)
                    //emojiOptionsOverlay.updateHeartEmoji(isFilled: false, isFocused: false)
                } else {
                    cards[0].showOptionLabel(option: .like2)
                    emojiOptionsOverlay.showEmoji(for: .like2)
                    //emojiOptionsOverlay.updateHeartEmoji(isFilled: false, isFocused: false)
                }
            } else if cards[0].center.x < (self.view.center.x - requiredOffsetFromCenter) {
                
                //emojiOptionsOverlay.updateHeartEmoji(isFilled: false, isFocused: false)
                
                if cards[0].center.y < (self.view.center.y - optionLength) {
                    cards[0].showOptionLabel(option: .dislike1)
                    emojiOptionsOverlay.showEmoji(for: .dislike1)
                } else if cards[0].center.y > (self.view.center.y + optionLength) {
                    cards[0].showOptionLabel(option: .dislike3)
                    emojiOptionsOverlay.showEmoji(for: .dislike3)
                } else {
                    cards[0].showOptionLabel(option: .dislike2)
                    emojiOptionsOverlay.showEmoji(for: .dislike2)
                }
            } else {
                cards[0].hideOptionLabel()
                emojiOptionsOverlay.hideFaceEmojis()
            }
            
        case .ended:
            
            dynamicAnimator.removeAllBehaviors()
            
           // print(num)
                emojiOptionsOverlay.hideFaceEmojis()
                if !(cards[0].center.x > (self.view.center.x + requiredOffsetFromCenter) || cards[0].center.x < (self.view.center.x - requiredOffsetFromCenter)) {
                    // snap to center
                    let snapBehavior = UISnapBehavior(item: cards[0], snapTo: self.view.center)
                    dynamicAnimator.addBehavior(snapBehavior)
                } else {
                    num = emojiOptionsOverlay.activeSmile
                    game.results[game.results.count - cards.count].rating += num
                    let velocity = sender.velocity(in: self.view)
                    let pushBehavior = UIPushBehavior(items: [cards[0]], mode: .instantaneous)
                    pushBehavior.pushDirection = CGVector(dx: velocity.x/10, dy: velocity.y/10)
                    pushBehavior.magnitude = 175
                    dynamicAnimator.addBehavior(pushBehavior)
                    // spin after throwing
                    var angular = CGFloat.pi / 2 // angular velocity of spin
                    
                    let currentAngle: Double = atan2(Double(cards[0].transform.b), Double(cards[0].transform.a))
                    
                    if currentAngle > 0 {
                        angular = angular * 1
                    } else {
                        angular = angular * -1
                    }
                    let itemBehavior = UIDynamicItemBehavior(items: [cards[0]])
                    itemBehavior.friction = 0.2
                    itemBehavior.allowsRotation = true
                    itemBehavior.addAngularVelocity(CGFloat(angular), for: cards[0])
                    dynamicAnimator.addBehavior(itemBehavior)
                    
                    showNextCard()
                    hideFrontCard()
                    if cards.count == 1 {
                        stopSliding()
                    }
                }
        default:
            break
        }
    }
    
    func stopSliding() {
        self.addBlur()
        let alert = UIAlertController(title: "Готово!", message:"Передайте телефон следующему игроку", preferredStyle: .alert)

        let action = UIAlertAction(title: "Начать", style: .default) { [self] _ in
            
           // let sortedByValueDictionary = self.ratingCards.sorted { $0.1 > $1.1 }
            let width = self.view.frame.width * 0.7
            let height = width / 0.6
            //var images = [UIImage]()
            if (self.counter == 1) {
                var ratingCards = [ImageCard: Int]()
                for index in 0..<self.game.results.count {
                    let card = ImageCard(frame: CGRect(x: 0, y: 0, width: width, height: height), info: (self.game.persons[index].name, self.game.results[index].problem!, self.game.results[index].solution!))
                    ratingCards[card] = self.game.results[index].rating
                }
                let sortedByValueDictionary = ratingCards.sorted { $0.1 > $1.1 }
                var ratingData = [SlidingCardsData]()
                var count = 0
                for (card, rating) in sortedByValueDictionary {
                    count += 1
                          let renderer = UIGraphicsImageRenderer(size: card.bounds.size)
                           let image = renderer.image { ctx in
                               card.drawHierarchy(in: card.bounds, afterScreenUpdates: true)
                          }
                    ratingData.append(SlidingCardsData(image: image, rating: 5, title: "\(count) Место", subtitle: "Набрано очков: \(rating)", description: "Проблема \n\n\(card.problemText.text!)\n\nРешение:\n\n\(card.solveText.text!)"))
                    //images.append(image)
                }
                SliderViewController.isNull = true
                game.end = true
                GameNetwork.refreshGameOnFirebase(game: game)
                MainNavigationController.navigationController.pushViewController(RatingSliderViewController(slidingCards: ratingData, title: game.name), animated: false)
            } else {
                self.counter -= 1
                MainNavigationController.navigationController.pushViewController(SliderViewController(game: self.game, counter: self.counter), animated: false)
            }
            self.deleteBlur()
        }
        alert.addAction(action)
        addBlur()
        self.present(alert, animated: true)
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 55
        view.addSubview(blurEffectView)
    }
    
    func deleteBlur() {
        UIView.animate(withDuration: 0.25) {
            self.view.viewWithTag(55)?.alpha = 0
        }
    }

    
    /// This function continuously checks to see if the card's center is on the screen anymore. If it finds that the card's center is not on screen, then it triggers removeOldFrontCard() which removes the front card from the data structure and from the view.
    var cardIsHiding = false
    func hideFrontCard() {
        if #available(iOS 10.0, *) {
            var cardRemoveTimer: Timer? = nil
            cardRemoveTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (_) in
                guard self != nil else { return }
                if !(self!.view.bounds.contains(self!.cards[0].center)) {
                    cardRemoveTimer!.invalidate()
                    self?.cardIsHiding = true
                    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
                        self?.cards[0].alpha = 0.0
                    }, completion: { (_) in
                        self?.removeOldFrontCard()
                        self?.cardIsHiding = false
                    })
                }
            })
        } else {
            // fallback for earlier versions
            UIView.animate(withDuration: 0.2, delay: 1.5, options: [.curveEaseIn], animations: {
                self.cards[0].alpha = 0.0
            }, completion: { (_) in
                self.removeOldFrontCard()
            })
        }
    }
}

struct Item: CardSliderItem {
    var image: UIImage
    var rating: Int?
    var title: String
    var subtitle: String?
    var description: String?
}
