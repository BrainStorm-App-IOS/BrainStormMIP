//
//  SavedCardViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import UIKit

final class SavedCardViewController: UIViewController {
    private let output: SavedCardViewOutput
    
    private let savedCardsCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private var startBrainStormButton: UIColorButton = UIColorButton(pressedColor: .red, notPressedColor: .orange)
    

    
    init(output: SavedCardViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        savedCardsCollectionView.pin.all()
    }
    
    func setupSavedCardsCollectionView(){
        savedCardsCollectionView.delegate = self
        savedCardsCollectionView.dataSource = self
        savedCardsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        savedCardsCollectionView.register(SavedCardCollectionViewCell.self)
        
        
        view.backgroundColor = .systemBackground
        view.addSubview(savedCardsCollectionView)
        
    }
    
    func setupStartBrainStormButton(){
        startBrainStormButton.setTitle("Start BrainStorm", for: .normal)
        startBrainStormButton.frame.size = CGSize(width: Const.startBrainStormButtonWidth,
                                                  height: Const.startBrainStormButtonHight)
        startBrainStormButton.backgroundColor = .orange
        startBrainStormButton.layer.cornerRadius = Const.startBrainStormButtonCornerRadius
        startBrainStormButton.layer.borderWidth = Const.startBrainStormButtonBorderWidth
        startBrainStormButton.center.x = self.view.center.x
        startBrainStormButton.center.y = Const.startBrainStormButtonY
        
        startBrainStormButton.addTarget(self, action: #selector(startBrainStorm), for: .touchUpInside)
        self.view.addSubview(startBrainStormButton)
    }
    
    func setup(){
        self.title = "BrainStorm"
        
        setupSavedCardsCollectionView()
        setupStartBrainStormButton()
        
        
    }
    
    
    @objc
    func startBrainStorm(){
        output.openBrainStromSettings()
    }
    
    
}

private extension SavedCardViewController {
    struct Const{
        static let cellHight: CGFloat = 100
        static let cellOffset: CGFloat = 13
        static let cellSideIndentation: CGFloat = 8
        static let startBrainStormButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let startBrainStormButtonHight: CGFloat = 50
        static let startBrainStormButtonCornerRadius: CGFloat = 10
        static let startBrainStormButtonBorderWidth: CGFloat = 4
        static let startBrainStormButtonY: CGFloat = UIScreen.screenHeight/2 +
                                                     UIScreen.screenHeight/4 +
                                                     UIScreen.screenHeight/8 -
                                                     UIScreen.screenHeight/32 +
                                                     UIScreen.screenHeight/64
        
    }
}

extension SavedCardViewController: SavedCardViewInput {
}

extension SavedCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedCardsCollectionView.dequeueReusableCell(SavedCardCollectionViewCell.self, for: indexPath)
        cell.configure(with: output.getItem(in: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width - 2 * Const.cellSideIndentation
        
        return .init(width: cellWidth, height: Const.cellHight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: Const.cellOffset, bottom: 0, right: Const.cellOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Const.cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Const.cellOffset
    }
    
}

extension SavedCardViewController{
    func reloadData(){
        savedCardsCollectionView.reloadData()
    }
}
