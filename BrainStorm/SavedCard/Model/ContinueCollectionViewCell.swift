//
//  ContinueCollectionViewCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/23/22.
//

import Foundation
import UIKit

final class ContinueCollectionViewCell: UICollectionViewCell {
    
    private let continueLabel: UILabel = UILabel()
    
    private let chevronImage: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))!.withTintColor(Color.defaltBlue | .white, renderingMode: .alwaysOriginal))
    
    private let titleLabel: UILabel = UILabel()
    
    private let desctiptionLabel: UILabel = UILabel()
    
    private let dateLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    //MARK: - layoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin
            .top(10)
            .left(10)
            .sizeToFit()

        desctiptionLabel.pin
            .bottom(5)
            .left(10)
            .marginTop(10)
            .sizeToFit()
        
        continueLabel.pin
            .right(60)
            .vCenter()
            .sizeToFit()


        chevronImage.pin
            .right(20)
            .vCenter()
    }
    
    //MARK: - setup
    
    private func setup() {
        setupCard()
        setupDate()
        setupTitle()
        setupDescription()
        setupContinueLabel()
        setupChevronImage()
    }
    
    func setupContinueLabel() {
        continueLabel.font = .systemFont(ofSize: 28, weight: .regular)
        continueLabel.textColor = .black | .white
        continueLabel.text = "Continue"
        
        contentView.addSubview(continueLabel)
    }
    
    func setupTitle(){
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black | .white

        
        contentView.addSubview(titleLabel)
    }
    
    func setupChevronImage() {
        
        contentView.addSubview(chevronImage)
    }
    
    func setupDescription(){
        desctiptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        desctiptionLabel.textAlignment = .right
        desctiptionLabel.textColor = .gray | .white
        
        contentView.addSubview(desctiptionLabel)
    }
    
    func setupDate(){
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .gray | .white
    }
    
    func setupCard(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1) | Color.defaultGray
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
    }
    
    func configure(with savedCard: GameModel) {
        defer {
            setNeedsLayout()
        }
        titleLabel.text = savedCard.name
        desctiptionLabel.text = "\(savedCard.theme ?? "None") " + "•" + " \(savedCard.date ?? "0.0.0")"
    }
}
