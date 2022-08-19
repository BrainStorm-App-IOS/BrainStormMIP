//
//  UIButtonExtension.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import Foundation
import UIKit

final class UIColorButton: UIButton{
    var pressedColor: UIColor?
    var notPressedColor: UIColor?
    convenience init(pressedColor: UIColor, notPressedColor: UIColor){
        self.init()
        self.pressedColor = pressedColor
        self.notPressedColor = notPressedColor
    }
    
    public override var isHighlighted: Bool {
        didSet {
            if let pressedColor = self.pressedColor, let notPressedColor = self.notPressedColor{
                backgroundColor = isHighlighted ? pressedColor : notPressedColor
            }
        }
    }
}


final class UIImageButton: UIButton{
    var pressedImage: UIImage?
    var notPressedImage: UIImage?

    
    convenience init(pressedImage: UIImage, notPressedImage: UIImage){
        self.init()
        self.pressedImage = pressedImage
        self.notPressedImage = notPressedImage
    }
    
    public override var isHighlighted: Bool {
        didSet {
            if let pressedImage = self.pressedImage, let notPressedImage = self.notPressedImage{
                setImage(isHighlighted ? pressedImage : notPressedImage, for: .normal)
            }
        }
    }
}
