//
//  SavedCardTableViewCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import Foundation

import UIKit

final class SavedCardCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let desctiptionLabel = UILabel()
    
    private var currentImageName: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .red
        desctiptionLabel.font = .systemFont(ofSize: 19, weight: .medium)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(desctiptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.pin
            .top()
            .marginTop(8)
            .horizontally(8)
            .height(24)
        
        desctiptionLabel.pin
            .below(of: titleLabel)
            .marginTop(8)
            .horizontally(8)
            .height(22)
    }
    
    func configure(with savedCard: SavedCard) {
        defer {
            setNeedsLayout()
        }
        titleLabel.text = savedCard.brainStormName
        desctiptionLabel.text = savedCard.brainStormDescription
    }
}
