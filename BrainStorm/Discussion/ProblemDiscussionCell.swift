//
//  ProblemDiscussionCell.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation
import UIKit

protocol ProblemAlert: AnyObject {
    func showCanselAlert()
    func reloadData()
}

final class ProblemDiscussionCell: UICollectionViewCell{
    
    static var tappedCells: Set<Int> = []
    
    weak var view: ProblemAlert?
    
    private var color: UIColor?
    
    private let problemTextView: UITextView = UITextView()
    private var checkView = UIView()
    
    private var isChoosenView: UIView = UIView()
    
    private var index: Int?
    
    static var count: Int?
    
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
        setupIsChoosenView()
    }
    
    private func setupIsChoosenView() {
        isChoosenView.layer.cornerRadius = 20
        isChoosenView.layer.borderWidth = 2
        
        checkView.layer.cornerRadius = 15
        checkView.backgroundColor = .black
        
        isChoosenView.addSubview(checkView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        isChoosenView.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        
        contentView.addSubview(isChoosenView)
    }
    private func setupCard() {
        
        contentView.isUserInteractionEnabled = true
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0
    }
    
    private func setupProblemTextView() {
        problemTextView.isEditable = false
        problemTextView.layer.cornerRadius = 20
        problemTextView.textContainer.lineBreakMode = .byWordWrapping
        problemTextView.backgroundColor = .none
        
        contentView.addSubview(problemTextView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isChoosenView.pin
            .size(CGSize(width: 40, height: 40))
            .top(5)
            .right(5)
        
        checkView.pin
            .size(CGSize(width: 30, height: 30))
            .center()
        
        
        problemTextView.pin
            .width(contentView.width)
            .height(contentView.height)
            .top()
            .left()
        
        problemTextView.textContainer.exclusionPaths = [UIBezierPath(rect: isChoosenView.frame)]
    }
    
    func configure(number: Int, text: String, problemAlert: ProblemAlert){
        defer {
            setNeedsLayout()
        }
        color = ColorsForCards.colors[number % 8]
        self.index = number
        
        self.view = problemAlert
        
        problemTextView.text = text
        
        if ProblemDiscussionCell.tappedCells.contains(index!) {
            checkView.backgroundColor = .black
        }
        
        else {
            checkView.backgroundColor = color
        }
            
        contentView.backgroundColor = color
        isChoosenView.backgroundColor = color
        
    }
    
    @objc
    func tapped(gestureRecognizer: UITapGestureRecognizer) {
        if ProblemDiscussionCell.tappedCells.contains(index!) {
            checkView.backgroundColor = isChoosenView.backgroundColor
            ProblemDiscussionCell.tappedCells.remove(index!)
        }
        else {
            if ProblemDiscussionCell.tappedCells.count == ProblemDiscussionCell.count! {
                view?.showCanselAlert()
            }
            
            else {
                checkView.backgroundColor = .black
                ProblemDiscussionCell.tappedCells.insert(index!)
            }
            
        }
    }
}


extension ProblemDiscussionCell: UIGestureRecognizerDelegate {
    
}
