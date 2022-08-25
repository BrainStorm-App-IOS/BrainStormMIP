//
//  SignInHeaderView.swift
//  BrainStorm
//
//  Created by Павел Вяльцев on 15.08.2022.
//

import UIKit

class SignInHeaderView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "auth_idea"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = ""
        label.textColor = .red
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = width/2
        imageView.frame = CGRect(x: (width - size)/2, y: 10, width: size, height: size)
        label.frame = CGRect(x: 20, y: imageView.bottom + 10, width: width - 40, height: height - size - 30)
    }
}
