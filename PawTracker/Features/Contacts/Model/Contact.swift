//
//  Contact.swift
//  PawTracker
//
//  Created by Simon Topliss on 05/05/2023.
//

import Foundation

// MARK: - Contact
struct Contact: Identifiable {
    var id: UUID
    var name: String
    var address: String
    var postCode: String
    var phoneNumber: String
}

extension Contact {
    static let mockContacts: [Contact] = Bundle.main.decode(Constants.JSONFiles.contacts)
    static let mockContact = mockContacts[0]
}

extension Contact {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case postCode = "post_code"
        case phoneNumber = "phone_number"
    }
}

extension Contact: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.postCode = try container.decode(String.self, forKey: .postCode)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
    }
}

extension Contact: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.postCode, forKey: .postCode)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
    }
}

typealias Contacts = [Contact]
