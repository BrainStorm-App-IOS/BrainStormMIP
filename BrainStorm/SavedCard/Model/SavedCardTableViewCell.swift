//
//  SavedCardTableViewCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import Foundation

import UIKit

final class SavedCardCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    //MARK: - defenition
    
    private let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    private let desctiptionLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
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
        
//        titleLabel.pin
//            .top(5)
//            .left(10)
//
//        desctiptionLabel.pin
//            .below(of: titleLabel, aligned: .left)
//            .marginTop(5)
//
//        dateLabel.pin
//            .hor
//            .marginLeft(5)
    }
    
    //MARK: - setup
    
    private func setup() {
        setupCard()
        setupDate()
        setupTitle()
        setupDescription()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        contentView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
            if gestureReconizer.state != UIGestureRecognizer.State.ended {
                print("start")
            }
            else {
                print("finish")
            }
        }
    
    func setupTitle(){
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black | .white

        
        contentView.addSubview(titleLabel)
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
        
        contentView.addSubview(dateLabel)
    }
    
    func setupCard(){
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1) | .blue
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CGColor(red: 0, green: 0, blue: 255, alpha: 1)
    }
    
    func configure(with savedCard: SavedCard) {
        defer {
            setNeedsLayout()
        }
        
        dateLabel.text = savedCard.brainStormDate
        titleLabel.text = savedCard.brainStormName
        desctiptionLabel.text = savedCard.brainStormDescription
    }
}
