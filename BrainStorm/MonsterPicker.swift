//
//  MonstersPicker.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/17/22.
//

import Foundation
import UIKit
//
//final class MonstersPicker: UIViewController{
//    var collectionView:UICollectionView!
//    private var monsters: [UIImage] = []
//    }
//    
//    func setupCollectionView(){
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: 70, height: 70)
//        layout.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: 70, height: 70)
//        layout.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let alert:UIAlertController = UIAlertController(title: "choose photo", message: "\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet)
//
//        let margin:CGFloat = 40.0
//        let viewmargin:CGFloat = 10.0
//        let rect = CGRect(x: viewmargin, y: margin, width: alert.view.bounds.size.width - viewmargin * 4.0, height: 100)
//        let customView = UIView(frame: rect)
//        //            customView.backgroundColor = .green
//        customView.layer.masksToBounds = true
//        customView.layer.cornerRadius = 5
//        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.register(UINib(nibName: "PhotoInActionSheetCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCollectionCell")
//        self.collectionView.backgroundColor = UIColor.clear
//
//        customView.addSubview(self.collectionView)
//
//        self.collectionView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 0).isActive = true
//        self.collectionView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 0).isActive = true
//        self.collectionView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 0).isActive = true
//        self.collectionView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: 0).isActive = true
//
//        alert.view.addSubview(customView)
//
//        self.imagePicker.delegate = self
//        alert.addAction(cameraAction)
//        alert.addAction(gallaryAction)
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//}
//
//extension MonstersPicker: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout{
//    //MARK: - colection view in actionsheet
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 30
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath)
//        cell.ImagePre.image = monsters[indexPath.row]
//        cell.ImagePre.layer.cornerRadius = 5
//        cell.ImagePre.layer.masksToBounds  = true
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let cellSize = CGSize(width: 70, height: 70)
//        //
//        return cellSize
//    }
//}


final class chooseMonsterPicker: UICollectionView{
    
    init(){
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func downloadMonsters(){
//        for i in 0..<200{
//            if i < 10{
//                monsters.append(UIImage(named: "CryptoFluff_000\(i)")!)
//            }
//            else if i < 100{
//                monsters.append(UIImage(named: "CryptoFluff_00\(i)")!)
//            }
//            else{
//                monsters.append(UIImage(named: "CryptoFluff_0\(i)")!)
//            }
//        }
//    }
        
    
}
