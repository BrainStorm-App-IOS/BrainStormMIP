//
//  SceneDelegate.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        GameNetwork.createGameOnFirebase(game: GameModel(end: false, name: "Andrey", countOfPersons: 4, persons: [PersonModel(name: "anmamn", pickedProblem: "AFaf", solution: "afaef", writtenProblems: ["adad,", "afaefaf", "afeafae"])], results: [ResultModel(problem: "AFFAEAEF", solution: "AFEAEFAEFAEFAEF", rating: 10)], stage: 2, stoppedPerson: 3, theme: "fsfsf", timer: 1000, date:  "11022002"))
        
        GameNetwork.fetchAllGameOfCurrentUser()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // TODO: Update VC to sign in VC if not
        let vc: UIViewController
        if AuthManager.shared.isSignedIn {
            vc = TabBarController()
        } else {
            let signInVc = SignInViewController()
            signInVc.navigationItem.largeTitleDisplayMode = .always
            
            let navVc = UINavigationController(rootViewController: signInVc)
            navVc.navigationBar.prefersLargeTitles = true
            vc = navVc
            
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
