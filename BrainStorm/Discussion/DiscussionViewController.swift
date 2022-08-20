//
//  DiscussionViewController.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//  
//

import UIKit

final class DiscussionViewController: UIViewController {
    private let output: DiscussionViewOutput
    private let themesCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 500), collectionViewLayout: layout)
        return collection
    }()
    private let notions : [String] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    private var currentTapped: IndexPath?

    init(output: DiscussionViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupPlayersCollectionView(){
        themesCollectionView.delaysContentTouches = false
        themesCollectionView.delegate = self
        themesCollectionView.dataSource = self
        themesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        themesCollectionView.register(ThemeViewCell.self)
        view.addSubview(themesCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        themesCollectionView.pin
                .size(CGSize(width: UIScreen.screenWidth, height: 550))
                .left()
                .right()
                .marginTop(10)
                .marginBottom(10)
                .bottom()
    }
}

extension DiscussionViewController: DiscussionViewInput {
}


//MARK: - Const
private extension DiscussionViewController {
    struct Const{
        static let MaxCountOfPlayers: Int = 10
        static let textFieldHight: CGFloat = 30
        static let textFieldSideIndentation: CGFloat = 36
        static let brainStormSendNameAndDescriptionButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let brainStormSendNameAndDescriptionButtonHight: CGFloat = 50
        static let brainStormSendNameAndDescriptionButtonY: CGFloat = UIScreen.screenHeight/2
                                                                    + UIScreen.screenHeight/4
                                                                    + UIScreen.screenHeight/8
                                                                    - UIScreen.screenHeight/32
                                                                    + UIScreen.screenHeight/64
    }
}

extension DiscussionViewController: StartBrainStormViewInput {
}

//MARK: - UICollectionProtocols


extension DiscussionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = themesCollectionView.dequeueReusableCell(ThemeViewCell.self, for: indexPath)
        cell.configure(theme: notions[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width - 3 * Const.textFieldSideIndentation)/2
        
        return .init(width: cellWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 22,
                     left: Const.textFieldSideIndentation,
                     bottom: 22,
                     right: Const.textFieldSideIndentation)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeViewCell {
            cell.contentView.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
            cell.newLabelTextColor(color: .white)
            if let current = currentTapped {
                let lastCell = collectionView.cellForItem(at: current) as? ThemeViewCell
                lastCell?.newLabelTextColor(color: UIColor(red: 0.506, green: 0.549, blue: 0.6, alpha: 1))
                lastCell?.contentView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 1)
            }
            
        }
        currentTapped = indexPath
    }

    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
    }
    
}

extension DiscussionViewController{
    func reloadData(){
        themesCollectionView.reloadData()
    }
}


