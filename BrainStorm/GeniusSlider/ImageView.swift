//
//  ImageView.swift
//  cardsSwipeUI
//
//  Created by Павел Вяльцев on 20.08.2022.
//

import UIKit

class ImageCard: CardView {
    
    init(frame: CGRect, info: (String, String, String)) {
        super.init(frame: frame)
        
        let problemLabel = UILabel()
        problemLabel.text = "Проблема"
        problemLabel.frame = CGRect(x: 20, y: 20, width: 200, height: 24)
        problemLabel.layer.masksToBounds = true
        problemLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        self.addSubview(problemLabel)
        
        let problemText = UITextView()
        problemText.isEditable = false
        problemText.text = info.1
        problemText.font = UIFont.systemFont(ofSize: 18.0)
        problemText.contentMode = .scaleAspectFill
        problemText.backgroundColor = UIColor(red: 0.8, green: 0.894, blue: 1, alpha: 1)
        problemText.layer.cornerRadius = 18
        problemText.layer.masksToBounds = true
        problemText.frame = CGRect(x: 1, y: problemLabel.bottom + 10, width: self.frame.width - 2, height: self.frame.height/2)
        self.addSubview(problemText)
        
        
        let solveLabel = UILabel()
        solveLabel.text = "Решение"
        solveLabel.frame = CGRect(x: 20, y: problemText.bottom + 20, width: 200, height: 24)
        solveLabel.layer.masksToBounds = true
        solveLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        self.addSubview(solveLabel)
        
        let solveText = UITextView()
        solveText.isEditable = false
        solveText.text = info.2
        solveText.font = UIFont.systemFont(ofSize: 18)
        solveText.contentMode = .scaleAspectFill
        solveText.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1)
        solveText.layer.cornerRadius = 18
        solveText.layer.masksToBounds = true
        solveText.frame = CGRect(x: 1, y: solveLabel.bottom + 10, width: self.frame.width - 2, height: self.bottom - solveLabel.bottom - 10)
        self.addSubview(solveText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

