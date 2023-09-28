//
//  Helpers.swift
//  ModelTests
//
//  Created by Simon Topliss on 05/05/2023.
//

import Foundation

func isoDateAsDate(_ isoDate: String) -> Date {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    // swiftlint:disable:next force_unwrapping
    return formatter.date(from: isoDate)!
}
