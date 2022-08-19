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
    
    
    private var startBrainStormButton: UIImageButton = UIImageButton(pressedImage: UIImage(systemName: "bolt.fill")!.withTintColor(.white),
                                                                     notPressedImage: UIImage(systemName:"plus")!)
    

    
    init(output: SavedCardViewOutput) {
        self.output = output
    
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        setup()
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        savedCardsCollectionView.pin.all()
        
        startBrainStormButton.pin
            .bottom(UIScreen.screenHeight - Const.startBrainStormButtonY - 20)
            .hCenter(to: view.edge.hCenter)
    }
    
    func setupSavedCardsCollectionView(){
        savedCardsCollectionView.delegate = self
        savedCardsCollectionView.dataSource = self
        savedCardsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        savedCardsCollectionView.register(SavedCardCollectionViewCell.self)
        
        
        view.addSubview(savedCardsCollectionView)
        
    }
    
    func setupStartBrainStormButton(){
        startBrainStormButton.setTitle("Start BrainStorm", for: .normal)
        startBrainStormButton.setImage(UIImage(systemName: "plus"), for: .normal)
        startBrainStormButton.frame.size = CGSize(width: Const.startBrainStormButtonWidth,
                                                  height: Const.startBrainStormButtonHight)
        startBrainStormButton.backgroundColor = .blue | .white
        startBrainStormButton.tintColor = .white | .black
        startBrainStormButton.setTitleColor(.white | .black, for: .normal)
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
        static let cellHight: CGFloat = 180
        static let cellOffset: CGFloat = 20
        static let cellSideIndentation: CGFloat = 8
        static let startBrainStormButtonWidth: CGFloat = UIScreen.screenWidth/2 + UIScreen.screenWidth/4
        static let startBrainStormButtonHight: CGFloat = 50
        static let startBrainStormButtonCornerRadius: CGFloat = 20
        static let startBrainStormButtonBorderWidth: CGFloat = 0
        static let startBrainStormButtonY: CGFloat = UIScreen.screenHeight/2
                                                   + UIScreen.screenHeight/4
                                                   + UIScreen.screenHeight/8
                                                   - UIScreen.screenHeight/32
                                                   + UIScreen.screenHeight/64
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didTapCard(savedCard: SavedCard(brainStormName: output.getItem(in: indexPath.row).brainStormName,
                                               brainStormDescription: output.getItem(in: indexPath.row).brainStormDescription,
                                               brainStormDate: output.getItem(in: indexPath.row).brainStormDate))
    }
    
}

extension SavedCardViewController{
    func reloadData(){
        savedCardsCollectionView.reloadData()
    }
}
