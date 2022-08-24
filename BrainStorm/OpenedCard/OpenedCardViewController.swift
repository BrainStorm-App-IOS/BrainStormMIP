//
//  OpenedCardViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/15/22.
//  
//

import UIKit

final class OpenedCardViewController: UIViewController {
    
    //MARK: - defenition
    private let output: OpenedCardViewOutput
    private let savedCard: GameModel
    
    private var nameLabel: UILabel = UILabel()
    private var DescriptionLabel: UILabel = UILabel()
    init(output: OpenedCardViewOutput, savedCard: GameModel) {
        self.output = output
        self.savedCard = savedCard

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        set(savedCard: savedCard)
        setup()
    }
}

extension OpenedCardViewController {
    
    //MARK: - setup
    func setup(){
        view.addSubview(nameLabel)
        view.addSubview(DescriptionLabel)
        
        
        view.backgroundColor = .blue
    }
    
    //MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameLabel.pin
            .top(view.pin.safeArea.top + 32)
            .horizontally(32)
            .sizeToFit(.width)
        
        DescriptionLabel.pin
            .below(of: nameLabel)
            .top(30)
            .horizontally(32)
            .sizeToFit(.width)
    }
}


//MARK: - OpenedCardViewInput

extension OpenedCardViewController: OpenedCardViewInput {
    func set(savedCard: GameModel) {
        nameLabel.text = savedCard.name
        DescriptionLabel.text = savedCard.theme
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

