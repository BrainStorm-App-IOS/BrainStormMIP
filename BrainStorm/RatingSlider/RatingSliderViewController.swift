import UIKit
//mport CardSlider

struct SlidingCardsData: CardSliderItem {
    let image: UIImage
    let rating: Int?
    let title: String
    let subtitle: String?
    let description: String?
}

class RatingSliderViewController: UIViewController {
    
    let slidingCards: [SlidingCardsData]
    let commandName: String
    
    init(slidingCards: [SlidingCardsData], title: String) {
        self.slidingCards = slidingCards
        self.commandName = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(didTapSignOut))
        let cardSlider = CardSliderViewController.with(dataSource: self)
        cardSlider.title = commandName
        cardSlider.modalPresentationStyle = .fullScreen
       
        self.view.addSubview(cardSlider.view)
        
        cardSlider.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardSlider.view.topAnchor.constraint(equalTo: view.topAnchor),
            cardSlider.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardSlider.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardSlider.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        self.addChild(cardSlider)
        cardSlider.didMove(toParent: self)
        
    }
    
    @objc private func didTapSignOut() {
        
    }
}

extension RatingSliderViewController: CardSliderDataSource {
    func item(for index: Int) -> CardSliderItem {
        return slidingCards[index]
    }
    
    func numberOfItems() -> Int {
        return slidingCards.count
    }
    
}
