//
//  TableCellRegistrationExtension.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifire: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.reuseIdentifire)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifire, for: indexPath) as? T else {
            fatalError("Can't dequeueReusableCell for \(T.reuseIdentifire)")
        }
        
        return cell
    }
}
