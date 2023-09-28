//
//  PetValidator.swift
//  PawTracker
//
//  Created by Simon Topliss on 02/04/2023.
//

import Foundation

struct PetValidator {

    func validate(_ pet: Pet) throws {
        if pet.name.isEmpty {
            throw CreatePetValidatorError.invalidName
        }

        if pet.type.isEmpty {
            throw CreatePetValidatorError.invalidType
        }
    }
}

extension PetValidator {
    enum CreatePetValidatorError: LocalizedError {
        case invalidName
        case invalidType
        case invalidGender
    }
}

extension PetValidator.CreatePetValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Pet name can't be empty"
        case .invalidType:
            return "Pet type can't be empty"
        case .invalidGender:
            return "Pet gender can't be empty"
        }
    }
}
