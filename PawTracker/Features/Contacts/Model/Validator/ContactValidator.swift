//
//  ContactValidator.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import Foundation

struct ContactValidator {

    func validate(_ contact: Contact) throws {
        if contact.name.isEmpty {
            throw CreateContactValidatorError.invalidName
        }

        if contact.address.isEmpty {
            throw CreateContactValidatorError.invalidAddress
        }

        if contact.phoneNumber.isEmpty {
            throw CreateContactValidatorError.invalidPhoneNumber
        }
    }
}

extension ContactValidator {
    enum CreateContactValidatorError: LocalizedError {
        case invalidName
        case invalidAddress
        case invalidPhoneNumber
    }
}

extension ContactValidator.CreateContactValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Contact name can't be empty"
        case .invalidAddress:
            return "Contact type can't be empty"
        case .invalidPhoneNumber:
            return "Telephone number can't be empty"
        }
    }
}
