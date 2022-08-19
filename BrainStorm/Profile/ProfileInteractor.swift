//
//  ProfileInteractor.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 18.08.2022.
//  
//

import Foundation

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
}

extension ProfileInteractor: ProfileInteractorInput {
}
