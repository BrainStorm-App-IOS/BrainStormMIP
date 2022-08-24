//
//  GameNetwork.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation
import Firebase

final class GameNetwork {
    
    private static var db = Firestore.firestore()
    private static var userEmail : String = (UserDefaults.standard.string(forKey: "email") ?? "").replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
    
    static func getName(completion: @escaping (Result<String, Error>) -> (Void)) {
        userEmail = (UserDefaults.standard.string(forKey: "email") ?? "").replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
        db.collection("users").document(userEmail).getDocument{ snapshot, err in
            if let err = err {
                print("[DEBUG] Error fetch games: \(err)")
            } else {
                completion(.success(snapshot?.data()?["name"] as? String ?? ""))
            }
        }
    }
    
    static func refreshGameOnFirebase (game : GameModel) {
        db.collection("games").document("\(String(describing: game.gameId))").setData(GameParser.getDataFromGameModel(model: game)) { err in
            if let err = err {
                print("[DEBUG] Error writing document: \(err)")
            } else {
                print("[DEBUG] Document successfully written!")
            }
        }
    }
    
    static func fetchAllGameOfCurrentUser(completion: @escaping (Result<[GameModel], Error>) -> (Void)) {
        var games : [GameModel] = []
        var ids : [String] = []
        userEmail = (UserDefaults.standard.string(forKey: "email") ?? "").replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
        
        db.collection("users").document(userEmail).getDocument{ snapshot, err in
            if let err = err {
                print("[DEBUG] Error fetch games: \(err)")
            } else {
                ids = snapshot?.data()?["gamesID"] as? [String] ?? []
                print("[DEBUG] ID's of games by user \(userEmail) : \(ids)")
                db.collection("games").getDocuments { snapshot, err in
                    if let err = err {
                        completion(.failure(err))
                        print("[DEBUG] Error get documents while fetching games: \(err)")
                    } else {
                        for document in snapshot!.documents {
                            print("[DEBUG] Document id : \(document.documentID)")
                            if ids.contains("\(document.documentID)") {
                                let game = GameParser.parseGame(gameDict: document.data())
                                print(game)
                                games.append(game)
                                print("[DEBUG] \(GameParser.getDataFromGameModel(model: game))")
                            }
                        }
                        completion(.success(games))
                    }
                }
            }
        }
    }
    
    static func createGameOnFirebase (game : GameModel /*@escaping completion*/) {
        // создание нового документа игры
        let docGamesRef = db.collection("games").document()
        game.gameId = docGamesRef.documentID
        //game.gameId = gameId
        docGamesRef.setData(GameParser.getDataFromGameModel(model: game)) { err in
            if let err = err {
                print("[DEBUG] Error writing document: \(err)")
            } else {
                print("[DEBUG] Document successfully written!")
            }
        }
        // запись id игры в users
        let docUserRef = db.collection("users").document(userEmail)
        docUserRef.updateData([
            "gamesID" : FieldValue.arrayUnion(["\(game.gameId)"])
        ])
    }
}
