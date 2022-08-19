//
//  ProfileSettingsViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            style: .done,
            target: self,
            action: #selector(didTapSignOut))
       
    }
    
    @objc private func didTapSignOut() {
        let sheet = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "name")
                        let signInVc = SignInViewController()
                        signInVc.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVc = UINavigationController(rootViewController: signInVc)
                        navVc.navigationBar.prefersLargeTitles = true
                        navVc.modalPresentationStyle = .fullScreen
                        self?.present(navVc, animated: true, completion: nil)
                    }
                }
                
            }
        }))
        
        present(sheet, animated: true)
        
    }
}
