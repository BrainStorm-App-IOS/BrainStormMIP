//
//  SavedCardRouter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import UIKit

final class SavedCardRouter {
    weak var viewController: UIViewController?
}

extension SavedCardRouter: SavedCardRouterInput {
    func openCard(output: OpenedCardModuleOutput, savedCard: GameModel) {
        print("___________________________")
        print(savedCard.results)
        print("___________________________")
        let width = MainNavigationController.navigationController.view.width * 0.7
        let height = width * 5 / 3
        var ratingCards = [ImageCard: Int]()
        for index in 0..<savedCard.results.count {
            let card = ImageCard(frame: CGRect(x: 0, y: 0, width: width, height: height), info: (savedCard.persons[index].name, savedCard.results[index].problem!, savedCard.results[index].solution!))
            ratingCards[card] = savedCard.results[index].rating
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
        }
        
        
        MainNavigationController.navigationController.pushViewController(RatingSliderViewController(slidingCards: ratingData, title: savedCard.name, oneScreen: true), animated: false)
    }
    
    func openBrainStormSettings(output: StartBrainStormModuleOutput){
        let startBrainStormContext = StartBrainStormContext(moduleOutput: output, game: GameModel())
        let startBrainStormContainer = StartBrainStormContainer.assemble(with: startBrainStormContext)
        
        startBrainStormContainer.viewController.hidesBottomBarWhenPushed = true
        //MainNavigationController.navigationController.navigationBar.isHidden = false
        MainNavigationController.navigationController.pushViewController(startBrainStormContainer.viewController, animated: true)
        
    }
}
