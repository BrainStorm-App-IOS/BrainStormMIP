//
//  ProblemCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//

import Foundation
import UIKit


final class ProblemCell: UICollectionViewCell {
    
    static var isOpen: Int = 0
    
    static var problemCell: ProblemCell?
    
    let problemTextView: UITextView = UITextView()
    
    private var index: Int!
    
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
        problemTextView.delegate = self
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
    
    func configure(number: Int, index: Int, text: String = ""){
        defer {
            setNeedsLayout()
        }
        if text != "" {
            problemTextView.text = text
        }
        
        self.index = index
        
        contentView.backgroundColor = ColorsForCards.colors[number]
        
    }
}


extension ProblemCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        ProblemCell.isOpen = index
        ProblemCell.problemCell = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
