//
//  EnterPlayerNameViewController.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import UIKit

final class EnterPlayerNameViewController: UIViewController {
    private let output: EnterPlayerNameViewOutput
    private let currPlayer: Int
    
    init(output: EnterPlayerNameViewOutput, currPlayer: Int) {
        self.output = output
        self.currPlayer = currPlayer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: constants and variables
    let avatarImage = UIImage(named: "CryptoFluff_0\(Int.random(in: 0...1))\(Int.random(in: 0...9))\(Int.random(in: 0...9))")
    let avatarImageView = UIImageView()
    
    let textLabel = UILabel()
    
    let nameField = UITextField()
    
    let addButton = UIButton()
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
        
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        width = view.bounds.width
        height = view.bounds.height
        
        setupAvatarImageViewFrame()
        setupTextLabel()
        setupNameField()
        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        addButton.pin
            .horizontally(16)
            .height(40)
            .bottom(view.pin.safeArea.bottom + 16)
    }
    
    // MARK: setup UI elements
    
    func setupAvatarImageViewFrame() {
        let avatarImageViewFrame = CGRect(x: width * 0.2, y: height * 0.1, width: width * 0.6, height: width * 0.6)
        avatarImageView.frame = avatarImageViewFrame
        avatarImageView.image = avatarImage
        avatarImageView.layer.cornerRadius = width * 0.3
        avatarImageView.clipsToBounds = true
        view.addSubview(avatarImageView)
    }
    
    func setupTextLabel() {
        textLabel.text = "Введите имя \(currPlayer)го игрока"
        textLabel.font = .systemFont(ofSize: 20)
        textLabel.sizeToFit()
        textLabel.center = CGPoint(x: width * 0.5, y: height * 0.15 + width * 0.6)
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
    }
    
    func setupNameField() {
        nameField.frame = CGRect(x: 0, y: 0, width: width * 0.8, height: 36)
        nameField.backgroundColor = UIColor(red: 0.949, green: 0.953, blue: 0.961, alpha: 1)
        nameField.layer.cornerRadius = 18
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor(red: 0.882, green: 0.89, blue: 0.902, alpha: 1).cgColor
        nameField.placeholder = "Введите имя"
        nameField.center = CGPoint(x: width * 0.5, y: height * 0.2 + width * 0.6)
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 36))
        nameField.leftViewMode = .always
        nameField.delegate = self
        view.addSubview(nameField)
    }
    
    func setupButton() {
        addButton.setTitle("Далее", for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 0
        addButton.backgroundColor = UIColor(red: 0.27, green: 0.373, blue: 0.913, alpha: 1)
        addButton.setTitleColor(.gray, for: .highlighted)
        addButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    //MARK: objs function
    
    @objc
    func pressedButton() {
        if let name = nameField.text {
            if name != "" {
                output.addPerson(name: name)
                output.nextPlayer()
            } else {
                nameField.attributedPlaceholder = NSAttributedString(string: "Введите имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            }
        }
    }
    
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        nameField.resignFirstResponder()
    }
}

// MARK: Extensions

extension EnterPlayerNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameField == textField {
            nameField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.attributedPlaceholder = nil
        textField.placeholder = "Введите имя"
    }
}

extension EnterPlayerNameViewController: EnterPlayerNameViewInput {
}
