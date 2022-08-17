//
//  ProfileSettingsViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    private let productsButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Profile"
        view.backgroundColor = .white | .black
        setup()
    }
    private var monsters: [UIImage] = []
    
    func downloadMonsters(){
        for i in 0..<200{
            if i < 10{
            monsters.append(UIImage(named: "CryptoFluff_000\(i)")!)
            }
            else if i < 100{
                monsters.append(UIImage(named: "CryptoFluff_00\(i)")!)
            }
            else{
                monsters.append(UIImage(named: "CryptoFluff_0\(i)")!)
            }
        }
    }
    private func setup() {
        view.addSubview(productsButton)
        productsButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        productsButton.layer.cornerRadius = 8
        productsButton.backgroundColor = .magenta
        productsButton.setTitle("Мои товары", for: .normal)
        productsButton.addTarget(self, action: #selector(didTapProductsButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        productsButton.pin
            .top(300)
            .horizontally(32)
            .height(40)
    }
    
    @objc
    private func didTapProductsButton() {
        let alert = UIAlertController(title: "hello", message: "go in ass", preferredStyle: .actionSheet)
        alert.isModalInPopover = true
        let monstersCollectionPicker: chooseMonsterPicker = chooseMonsterPicker()
        
        alert.view.addSubview(monstersCollectionPicker)
        let action = UIAlertAction(title: "OK", style: .cancel)
        //alert.view.addSubview(chooseCountOfPlayerPicker)
        alert.addAction(action)
        self.present(alert, animated: true)
        
        
        
}
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
