//
//  DatabaseManager.swift
//  BrainStorm
//
//  Created by Павел Вяльцев on 15.08.2022.
//

import Foundation
import FirebaseFirestore


final class DatabaseManager {
    static let shared = DatabaseManager()
    
   private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
        let documentId = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email": user.email,
            "name": user.name
        ]
        database.collection("users")
            .document(documentId)
            .setData(data) { error in
            completion(error == nil)
        }
    }
}
