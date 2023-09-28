//
//  Feature.swift
//  PawTracker
//
//  Created by Simon Topliss on 25/02/2023.
//

import Foundation

struct Feature: Decodable, Identifiable {

    // MARK: - PROPERTIES
    let id: UUID
    let title: String
    let description: String

    // MARK: - FEATURES FROM JSON
    static let allFeatures: [Feature] = Bundle.main.decode(Constants.JSONFiles.features)
}
