//
//  Pet.swift
//  PawTracker
//
//  Created by Simon Topliss on 25/02/2023.
//

import SwiftUI

struct Pet: Equatable, Identifiable, Hashable {

    var id: UUID
    var modDate: Date
    var name: String
    var type: String
    var breed: String
    var gender = Gender.unknown.rawValue
    var weight: Double
    var dateOfBirth: Date?
    var deceased = false
    var description: String
    var petImageName = "BlankPetImage"

    private var _petImage: UIImage?
    var petImage: UIImage {
        get {
            return loadPetImage()
        }
        set {
            _petImage = newValue
        }
    }

    func loadPetImage() -> UIImage {
        // Pet photos that the user has added
        let userImageURL = FileManager.documentsDirectory
            .appendingPathComponent(id.uuidString)
            .appendingPathExtension("jpg")
        if let jpgImage = UIImage(contentsOfFile: userImageURL.path) {
            return jpgImage
        }
        // swiftlint:disable:next force_unwrapping
        return UIImage(named: petImageName) ?? UIImage(named: Constants.General.blankPetImage)!
    }
}

extension Pet {
    static let mockPets: [Pet] = Bundle.main.decode(Constants.JSONFiles.pets)
    static let mockPet = mockPets[0]
}

extension Pet {
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case unknown = "Unknown"
    }
}

extension Pet {
    enum CodingKeys: String, CodingKey {
        case id
        case modDate
        case name
        case type
        case breed
        case gender
        case weight
        case dateOfBirth
        case deceased
        case description = "desc"
        case petImageName
    }
}

extension Pet {
    init(
        id: UUID,
        modDate: Date,
        name: String,
        type: String,
        breed: String,
        gender: Gender.RawValue,
        weight: Double,
        dateOfBirth: Date? = nil,
        deceased: Bool = false,
        description: String,
        petImageName: String = "BlankPetImage",
        petImage: UIImage
    ) {
        self.id = id
        self.modDate = modDate
        self.name = name
        self.type = type
        self.breed = breed
        self.gender = gender
        self.weight = weight
        self.dateOfBirth = dateOfBirth
        self.deceased = deceased
        self.description = description
        self.petImageName = petImageName
        self.petImage = loadPetImage()
    }
}

extension Pet: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(
            UUID.self,
            forKey: .id
        ) ?? UUID()

        self.modDate = try container.decodeIfPresent(
            Date.self,
            forKey: .modDate
        ) ?? Date()

        self.name = try container.decode(
            String.self,
            forKey: .name
        )

        self.type = try container.decode(
            String.self,
            forKey: .type
        )

        self.breed = try container.decodeIfPresent(
            String.self,
            forKey: .breed
        ) ?? ""

        self.gender = try container.decodeIfPresent(
            String.self,
            forKey: .gender
        ) ?? Gender.unknown.rawValue

        self.weight = try container.decode(
            Double.self,
            forKey: .weight
        )
        self.dateOfBirth = try container.decodeIfPresent(
            Date.self,
            forKey: .dateOfBirth
        )

        self.deceased = try container.decodeIfPresent(
            Bool.self,
            forKey: .deceased
        ) ?? false

        self.description = try container.decodeIfPresent(
            String.self,
            forKey: .description
        ) ?? ""

        self.petImageName = try container.decodeIfPresent(
            String.self,
            forKey: .petImageName
        ) ?? Constants.General.blankPetImage
    }
}

extension Pet: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(modDate, forKey: .modDate)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(breed, forKey: .breed)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encode(weight, forKey: .weight)
        try container.encodeIfPresent(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(deceased, forKey: .deceased)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(petImageName, forKey: .petImageName)
    }
}
