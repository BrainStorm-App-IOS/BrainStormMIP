//
//  PlayersCell.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/16/22.
//

import Foundation
import UIKit

final class PlayersViewCell: UICollectionViewCell{
    
    private let playerNameTextField: UITextField = UITextField(frame: CGRect(x: 150,
                                                                    y: 200,
                                                                    width: UIScreen.screenWidth -
                                                                    2 * Const.textFieldSideIndentation,
                                                                    height: Const.textFieldHight))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        setupCard()
        setupPlayerNameTextField()
    }
    
    func setupPlayerNameTextField(){
        playerNameTextField.delegate = self
        playerNameTextField.borderStyle = .roundedRect
        playerNameTextField.contentVerticalAlignment = .center
        playerNameTextField.textAlignment = .center
        playerNameTextField.placeholder = "Name"
        
        contentView.addSubview(playerNameTextField)
    }
    
    func setupCard(){
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .blue
        contentView.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        playerNameTextField.pin
            .top(10)
            .marginTop(8)
            .horizontally(8)
            .height(24)
    }
    
    
    
    struct Const{
        static let textFieldHight: CGFloat = 30
        static let textFieldSideIndentation: CGFloat = 8
        static let brainStormSendNameAndDescriptionButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let brainStormSendNameAndDescriptionButtonHight: CGFloat = 50
        static let brainStormSendNameAndDescriptionButtonY: CGFloat = UIScreen.screenHeight/2
                                                                    + UIScreen.screenHeight/4
                                                                    + UIScreen.screenHeight/8
                                                                    - UIScreen.screenHeight/32
                                                                    + UIScreen.screenHeight/64
        
    }
    func configure(){
        defer {
            setNeedsLayout()
        }
        
        playerNameTextField.placeholder = "Name"
    }
}


extension PlayersViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
