//
//  Constants.swift
//  PawTracker
//
//  Created by Simon Topliss on 18/02/2023.
//

import SwiftUI

enum Constants {

    enum General {
        public static let appName = "PawTracker"
        public static let appSubTitle = "Keep track of all your pets’ information"
        public static let blankPetImage = "BlankPetImage"
    }

    enum JSONFiles {
        public static let features = "features.json"
        public static let pets = "pets.json"
        public static let feeds = "feeds.json"
        public static let dailyFeeds = "daily-feeds.json"
        public static let events = "events.json"
        public static let contacts = "contacts.json"
    }

    enum TextStyle {
        public static let kerning = -0.5
    }

    enum Home {
        public static let showOnBoardingButtonName = "list.bullet.circle"
        public static let backgroundImageName = "BackgroundImage"
    }

    enum Onboarding {
        public static let titleWidth = 120.0
        public static let titleHeight = 44.0
        public static let descriptionMaxWidth = 400.0
        public static let featureFrameHeight = 66.0
        public static let featurePadding = 4.0
        public static let cornerRadius = 6.0

    }

    enum Shadows {
        public static let shadowColor = Color("Shadow")

        public static let largeRadius = 10.0
        public static let largeX = 6.0
        public static let largeY = 6.0

        public static let smallRadius = 4.0
        public static let smallX = 2.0
        public static let smallY = 2.0
    }

    enum ClipShapes {
        public static let largeRoundedRectangle = RoundedRectangle(
            cornerRadius: 10.0,
            style: .continuous
        )
        public static let smallRoundedRectangle = RoundedRectangle(
            cornerRadius: 4.0,
            style: .continuous
        )
    }

    enum AppColors {
        public static let brandPrimary = Color("BrandPrimary")
        public static let textColor = Color("TextColor")
        public static let grayBoxColor = Color("GrayBox")
    }

    enum AppSymbols {
        public static let addSymbol = "plus.circle.fill"
        public static let trashSymbol = "trash"
    }
}
