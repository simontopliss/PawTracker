//
//  ViewModel.swift
//  PawTracker
//
//  Created by Simon Topliss on 17/03/2023.
//

import CoreTransferable
import PhotosUI
import SwiftUI

final class PetViewModel: ObservableObject {

    // MARK: - PROPERTIES

    @Published var pets: [Pet] = []

    @Published var searchQuery = "" {
        didSet {
            filterPets()
        }
    }

    @Published var filteredPets: [Pet] = []

    private let validator = PetValidator()
    @Published var validatorError: PetValidator.CreatePetValidatorError?
    @Published var hasValidatorError = false

    init() {
        pets = loadPets()
        filteredPets = pets
    }

    func filterPets() {
        filteredPets = searchQuery.isEmpty
            ? pets
            : pets.filter {
                ($0.name.localizedCaseInsensitiveContains(searchQuery)) ||
                    ($0.type.localizedCaseInsensitiveContains(searchQuery)) ||
                    (!$0.breed.isEmpty && $0.breed.localizedCaseInsensitiveContains(searchQuery))
            }
    }

    func validatePet(_ pet: Pet) {
        do {
            try validator.validate(pet)
        } catch {
            hasValidatorError = true
            validatorError = error as? PetValidator.CreatePetValidatorError
            print(error.localizedDescription)
        }
    }

    func loadPets() -> [Pet] {
        do {
            let userPetsJSON = FileManager.documentsDirectory
                .appendingPathComponent("pets")
                .appendingPathExtension("json")
                .path

            let petsJSONPath = FileManager.default.fileExists(atPath: userPetsJSON)
                ? userPetsJSON
                : Bundle.main.path(forResource: "pets", ofType: "json")

            guard let petsJSONPath,
                  let data = FileManager.default.contents(atPath: petsJSONPath)
            // swiftlint:disable:previous indentation_width
            else {
                print("Unable to read JSON file.")
                return []
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode([Pet].self, from: data)

        } catch {
            print("loadPets() error:" + String(describing: error))
            return []
        }
    }

    func findPetByID(_ petID: UUID) -> Pet? {
        pets.first { $0.id == petID }
    }

    func findPetByName(_ petName: String) -> Pet? {
        pets.first { $0.name == petName }
    }

    func savePets() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.outputFormatting = .prettyPrinted

            let data = try? encoder.encode(pets)

            let savePath = FileManager.documentsDirectory
                .appendingPathComponent("pets")
                .appendingPathExtension("json")

            try data?.write(to: savePath, options: [.atomic, .completeFileProtection])

        } catch {
            print("savePets() error:\n\(error.localizedDescription)")
        }
    }

    func addPet(_ newPet: Pet) {
        pets.append(newPet)
        savePets()
    }

    func updatePet(_ pet: Pet) {
        guard let index = pets.firstIndex(where: { $0.id == pet.id }) else {
            addPet(pet)
            return
        }
        pets[index] = pet
    }

    func deletePet(_ petID: UUID) {
        pets.removeAll { $0.id == petID }
        savePets()
    }

    func savePetImage(pet: inout Pet, image: UIImage) {
        let fileName = pet.id.uuidString + ".jpg"
        let fileURL = FileManager.documentsDirectory.appendingPathComponent(fileName)

        // Check if an image with the same name already exists. If there is, delete it.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("Couldn't remove file at path", removeError)
            }
        }

        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }

        // Save image to disk
        do {
            try data.write(to: FileManager.documentsDirectory.appendingPathComponent(fileName))
            pet.petImage = image
            print("Successfully saved image \(fileName)")
            print(fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
