//
//  ThemeCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/16/22.
//

import Foundation
import UIKit


final class ThemeViewCell: UICollectionViewCell{
    
    let themeLabel: UILabel = UILabel()
    var currentTheme: Bool
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.currentTheme = false
        super.init(frame: frame)
        
        setup()
    }
    
    //MARK: - setup
    
    private func setup() {
        setupCard()
        setupPlayerNameTextField()
    }
    
    func setupPlayerNameTextField(){
        themeLabel.textAlignment = .center
        themeLabel.textColor = UIColor(red: 0.506, green: 0.549, blue: 0.6, alpha: 1)
        
        contentView.addSubview(themeLabel)
    }
    
    func setupCard(){
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0
        contentView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1) | Color.defaultGray
    }
    
    func newLabelTextColor(color: UIColor){
        themeLabel.textColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        themeLabel.pin
            .hCenter()
            .vCenter()
            .sizeToFit()
        
    }
    
    func configure(theme: String){
        defer {
            setNeedsLayout()
        }
        
        themeLabel.text = theme
    }
}
