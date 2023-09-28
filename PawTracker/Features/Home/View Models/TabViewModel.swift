//
//  TabViewModel.swift
//  PawTracker
//
//  Created by Simon Topliss on 23/03/2023.
//

import Foundation

enum Tab: Int {

    case home
    case pets
    case contacts
    case events
    case gallery
    case dailyFeeds

    var label: String {
        switch self {
        case .home:
            return "Home"
        case .pets:
            return "Pets"
        case .contacts:
            return "Contacts"
        case .events:
            return "Events"
        case .gallery:
            return "Gallery"
        case .dailyFeeds:
            return "Feeds"
        }
    }

    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .pets:
            return "list.bullet"
        case .contacts:
            return "phone.circle.fill"
        case .events:
            return "calendar"
        case .gallery:
            return "photo.stack"
        case .dailyFeeds:
            return "fork.knife.circle.fill"
        }
    }
}
