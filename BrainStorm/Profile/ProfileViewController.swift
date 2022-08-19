//
//  ProfileViewController.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 18.08.2022.
//  
//

import UIKit

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput

    private let name = UILabel()
    private let mail = UILabel()
    private let textUs = UIButton()
    private let themeButton = UIButton()
    private let imageProfileView = UIImageView(image: UIImage(named: "CryptoFluff_0157.jpg"))
//    private let imageSunView = UIImageView(image: UIImage(named: "cloudy-day.png"))
    
    init(output: ProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ProfileViewController: ProfileViewInput {
}

extension ProfileViewController {
    func setup(){
        
        setupImageProfileView()
//        setupImageSunView()
        setupLabelsView()
        
        view.addSubview(name)
//        view.addSubview(imageSunView)
        view.addSubview(mail)
        view.addSubview(textUs)
        view.backgroundColor = .white
        
    }
    
    func setupLabelsView() {
        self.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title:"Выйти",
            style: .done,
            target: self,
            action: #selector(didTapSignOut)
        )
        
        name.text = "Claristha"
        name.font = UIFont(name: "Inter-Bold", size: 20)
        name.frame = CGRect(x: 174, y: 195, width: 120, height: 18)
        name.sizeToFit()
        
        mail.text = "pavek.pupas@yabn.ru"
        mail.textColor = .gray
        mail.font = UIFont(name: "Inter-Regular", size: 16)
        mail.frame = CGRect(x: 174, y: 225, width: 180, height: 17)
        mail.sizeToFit()
        
        
        
        textUs.setAttributedTitle(NSAttributedString(string: "Напишите нам", attributes:
                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue]), for: .normal)
        textUs.titleLabel?.font = UIFont(name: "Inter-Regular", size: 16)
        textUs.frame = CGRect(x: view.bounds.width / 2 - 60, y: view.bounds.height - 140, width: 120, height: 17)
    }
    
    func setupImageProfileView() {
        imageProfileView.layer.cornerRadius = 100
        imageProfileView.clipsToBounds = true
        let imageViewFrame = CGRect(x: 20, y: 165, width: 120, height: 120)
        imageProfileView.frame = imageViewFrame
        imageProfileView.layer.cornerRadius = 120 / 2
        view.addSubview(imageProfileView)
    }
    
//    func setupImageSunView() {
//        view.addSubview(imageSunView)
//        let imageViewFrame = CGRect(x: view.bounds.width / 2 - 92, y: view.bounds.height / 2 - 92, width: 184, height: 184)
//        imageSunView.frame = imageViewFrame
//        imageSunView.layer.cornerRadius = 184 / 2
//        imageSunView.image = UIImage(named: "cloudy-day 1")
//
//
//    }
    
    @objc private func didTapSignOut() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
