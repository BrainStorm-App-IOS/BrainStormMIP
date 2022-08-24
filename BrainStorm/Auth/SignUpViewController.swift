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
        field.isSecureTextEntry = true
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(headerView)
        view.addSubview(signUpButton)
        let tmpEmail = emailField
        tmpEmail.delegate = self
        view.addSubview(tmpEmail)
        let tmpPassword = passwordField
        tmpPassword.delegate = self
        view.addSubview(tmpPassword)
        view.addSubview(signUpButton)
        let tmpName = nameField
        tmpName.delegate = self
        view.addSubview(tmpName)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height/3)
        nameField.frame = CGRect(x: 20, y: headerView.bottom + 60, width: view.bounds.width - 40, height: 50)
        emailField.frame = CGRect(x: 20, y: nameField.bottom + 20, width: view.bounds.width - 40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 20, width: view.bounds.width - 40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: passwordField.bottom + 30, width: view.bounds.width - 40, height: 50)
        
    }
    
    @objc func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty else {
            emailField.attributedPlaceholder = NSAttributedString(string: "Электронная почта", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            nameField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            passwordField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.6)])
            return
        }
        
        // Create User
        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if success {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(name, forKey: "имя")
                // Update database
                let newUser = User(name: name, email: email, profilePictureUrl: nil)
                DatabaseManager.shared.insert(user: newUser) { inserted in
                    guard inserted  else {
                        self?.headerView.label.text = "Ошибка при создании аккаунта"
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
                self?.headerView.label.text = "Ошибка при создании аккаунта"
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y += (view.bounds.height - keyboardSize.height - 700)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailField.attributedPlaceholder = nil
        emailField.placeholder = "Электронная почта"
        passwordField.attributedPlaceholder = nil
        passwordField.placeholder = "Пароль"
        nameField.attributedPlaceholder = nil
        nameField.placeholder = "Имя"
        self.headerView.label.text = ""
    }
}
