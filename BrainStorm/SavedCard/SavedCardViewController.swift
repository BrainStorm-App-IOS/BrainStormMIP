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
    
    init(output: SavedCardViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    private let SavedCardTableView = UITableView(frame: .zero, style: .plain)
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let savedCardsCollectionView:UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
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
    func setup(){
        self.view.backgroundColor = .black
        
        setupSavedCardsCollectionView()
        
    }
    
}

private extension SavedCardViewController {
    struct Const{
        static let cellHight: CGFloat = 100
        static let cellOffset: CGFloat = 13
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
        cell.backgroundColor = UIColor.blue
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width - 16
        
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
