//
//  SignUpViewController.swift
//  BrainStorm
//
//  Created by Павел Вяльцев on 15.08.2022.
//

import UIKit

class SignUpViewController: UITabBarController {
    
    private let headerView = SignInHeaderView()
    // Name field
    private let nameField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Имя"
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    // Email field
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Электронная почта"
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    // Password field
    private let passwordField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.autocorrectionType = .no
        field.placeholder = "Пароль"
        //field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    // Sign in button
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Создать аккаунт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 18
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Регистрация"
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(nameField)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height/5)
        
        
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height/4)
        nameField.frame = CGRect(x: 20, y: headerView.bottom + 40, width: view.bounds.width - 40, height: 50)
        emailField.frame = CGRect(x: 20, y: nameField.bottom + 20, width: view.bounds.width - 40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 20, width: view.bounds.width - 40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: passwordField.bottom + 30, width: view.bounds.width - 40, height: 50)

    }
    
    @objc func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty else {
            return
        }
        
        // Create User
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if success {
                // Update database
                let newUser = User(name: name, email: email, profilePictureUrl: nil)
                DatabaseManager.shared.insert(user: newUser) { inserted in
                    guard inserted  else {
                        return
                    }
                    UserDefaults.standard.set(email, forKey: "почта")
                    UserDefaults.standard.set(name, forKey: "имя")
                    DispatchQueue.main.async {
                        let vc = TabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                    }
                }
            } else {
                print("Ошибка при создании аккаунта")
            }
        }
    }
}
