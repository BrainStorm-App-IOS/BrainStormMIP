//
//  ProblemDiscussionCell.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation
import UIKit

final class ProblemDiscussionCell: UICollectionViewCell {
    
//    private let problemTextView: UITextView = UITextView()
    private var checkView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        setupCard()
//        setupProblemTextView()
    }
    
    private func setupCard() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0
    }
    
//    private func setupProblemTextView() {
//        problemTextView.layer.cornerRadius = 15
//        problemTextView.textContainer.lineBreakMode = .byWordWrapping
//        problemTextView.backgroundColor = .none
//
//        contentView.addSubview(problemTextView)
//    }
//
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        problemTextView.pin
//            .width(contentView.width)
//            .height(contentView.height)
//            .all()
        checkView.pin
            .all(20)
    }
    
    func addCheck() {
        let check = UIImage(systemName: "checkmark")!
        checkView = UIImageView(image: check)
        contentView.addSubview(checkView)
        layoutSubviews()
    }
    
    func removeCheck() {
        checkView.removeFromSuperview()
        layoutSubviews()
    }
    
    func configure(number: Int, text: String = ""){
        defer {
            setNeedsLayout()
        }
//        if text != "" {
//            problemTextView.text = text
//        }
//
        contentView.backgroundColor = ColorsForCards.colors[number%8]
        
    }
}

