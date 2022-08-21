//
//  ProblemCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//

import Foundation
import UIKit


final class ProblemCell: UICollectionViewCell {
    
    private let problemTextView: UITextView = UITextView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        setupCard()
        setupProblemTextView()
    }
    
    private func setupCard() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0
    }
    
    private func setupProblemTextView() {
        problemTextView.layer.cornerRadius = 15
        problemTextView.textContainer.lineBreakMode = .byWordWrapping
        problemTextView.backgroundColor = .none
        
        contentView.addSubview(problemTextView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        problemTextView.pin
            .width(contentView.width)
            .height(contentView.height)
            .all()
    }
    
    func configure(number: Int, text: String = ""){
        defer {
            setNeedsLayout()
        }
        if text != "" {
            problemTextView.text = text
        }
        
        contentView.backgroundColor = ColorsForCards.colors[number]
        
    }
}
