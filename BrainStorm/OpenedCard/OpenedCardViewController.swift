//
//  OpenedCardViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/15/22.
//  
//

import UIKit

final class OpenedCardViewController: UIViewController {
    private let output: OpenedCardViewOutput
    private let savedCard: SavedCard
    
    private var nameLabel: UILabel = UILabel()
    private var DescriptionLabel: UILabel = UILabel()
    init(output: OpenedCardViewOutput, savedCard: SavedCard) {
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
    func setup(){
        view.addSubview(nameLabel)
        view.addSubview(DescriptionLabel)
        
        
        view.backgroundColor = .blue
    }
    
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

extension OpenedCardViewController: OpenedCardViewInput {
    func set(savedCard: SavedCard) {
        nameLabel.text = savedCard.brainStormName
        DescriptionLabel.text = savedCard.brainStormDescription
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

