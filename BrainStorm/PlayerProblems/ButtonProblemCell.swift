//
//  ButtonProblemCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//

import Foundation

import Foundation
import UIKit


final class ButtonProblemCell: UICollectionViewCell {
    
    weak var problems: ProblemsIncr?
    
    private let newCellButton: UIButton = UIButton()
    
    private let configuration = UIImage.SymbolConfiguration(pointSize: 50)
    
    private var image: UIImage
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        image = UIImage(systemName: "plus", withConfiguration: configuration)!.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        super.init(frame: frame)
        
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        newCellButton.pin
            .width(60)
            .height(60)
            .hCenter()
            .vCenter()
    }
    
    private func setup() {
        setupCard()
        setupButton()
    }
    
    private func setupCard() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 40
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0
    }
    
    private func setupButton() {
        newCellButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        newCellButton.setImage(image, for: .normal)
        newCellButton.layer.cornerRadius = 30
        newCellButton.addTarget(self, action: #selector(newCell), for: .touchUpInside)
        
        contentView.addSubview(newCellButton)
    }
    
    @objc
    func newCell(){
        problems?.incrCountOfProblems()
    }
    
    func configure(problems: ProblemsIncr){
        defer {
            setNeedsLayout()
        }

        self.problems = problems
        
    }
}
