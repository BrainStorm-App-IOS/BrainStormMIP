//
//  UIColorExtension.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/16/22.
//

import Foundation
import UIKit

infix operator |: AdditionPrecedence
public extension UIColor {
    
    /// Easily define two colors for both light and dark mode.
    /// - Parameters:
    ///   - lightMode: The color to use in light mode.
    ///   - darkMode: The color to use in dark mode.
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
    static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
            
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}



struct Color{
    static let tapBarTincColor: UIColor = .blue | .yellow
    static let abBarUnselectedItemTintColor: UIColor = .black | .white
    static let defaultBlackAndWhiteColor: UIColor = .black | .white
    static let defaultWhiteAndBlackColor: UIColor = .white | .black
    
    static let defaltBlue: UIColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
    
}
