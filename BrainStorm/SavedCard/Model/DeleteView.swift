//
//  DeleteView.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/23/22.
//

import Foundation
import UIKit

final class DeleteView: UIView {
    
    private let yesButton: UIButton = UIButton()
    
    private let noButton: UIButton = UIButton()
    
    private let deleteLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        deleteLabel.pin
            .left()
            .vCenter()
            .sizeToFit()
        
        noButton.pin
            .right()
            .vCenter()
            .sizeToFit()
        
        yesButton.pin
            .verticallyBetween(deleteLabel, and: noButton, aligned: .center)
    }
    
    func setup() {
        setupDeleteLabel()
        setupYesButton()
        setupNoButton()
    }
    
    func setupDeleteLabel() {
        deleteLabel.text = "delete ?"
        
        addSubview(deleteLabel)
    }
    
    func setupNoButton() {
        yesButton.setTitle("YES", for: .normal)
        
        addSubview(yesButton)
    }
    
    func setupYesButton() {
        noButton.setTitle("NO", for: .normal)
        
        addSubview(noButton)
    }
}
