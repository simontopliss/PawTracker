//
//  AgeFromDOB.swift
//  PawTracker
//
//  Created by Simon Topliss on 10/03/2023.
//

import Foundation

extension Date {
    var daysInMonth: Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(
            year: calendar.component(.year, from: self),
            month: calendar.component(.month, from: self)
        )
        // swiftlint:disable:next force_unwrapping
        let date = calendar.date(from: dateComponents)!
        // swiftlint:disable:next force_unwrapping
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
}

struct YearMonthDay {
    var year: Int
    var month: Int
    var day: Int
}

/// Returns a struct containing the year, month and day of an age given a string in the format of "yyyy-MM-dd"
/// - Parameters:
///   - dob: Date of birth
///   - format: format of the date - default is "yyyy-MM-dd"
/// - Returns: struct of year, month, day
func calculateAge(_ dob: Date, format: String = "yyyy-MM-dd") -> YearMonthDay {
    var yearMonthDay = YearMonthDay(year: 0, month: 0, day: 0)

    let formatter = DateFormatter()
    formatter.dateFormat = format

    let cal = Calendar.current
    let currentDate = Date()
    yearMonthDay.year = cal.component(.year, from: currentDate) - cal.component(.year, from: dob)

    let currentMonth = cal.component(.month, from: currentDate)
    let birthMonth = cal.component(.month, from: dob)

    // Get difference between current month and birthMonth
    yearMonthDay.month = currentMonth - birthMonth

    // If month difference is in negative then reduce years by one and calculate the number of months.
    if yearMonthDay.month < 0 {
        yearMonthDay.year -= 1
        yearMonthDay.month = 12 - birthMonth + currentMonth
        if cal.component(.day, from: currentDate) < cal.component(.day, from: dob) {
            yearMonthDay.month -= 1
        }
    } else if yearMonthDay.month == 0, cal.component(.day, from: currentDate) < cal.component(.day, from: dob) {
        yearMonthDay.year -= 1
        yearMonthDay.month = 11
    }

    // Calculate the days
    if cal.component(.day, from: currentDate) > cal.component(.day, from: dob) {
        yearMonthDay.day = cal.component(.day, from: currentDate) - cal.component(.day, from: dob)
    } else if cal.component(.day, from: currentDate) < cal.component(.day, from: dob) {
        let today = cal.component(.day, from: currentDate)
        let date = cal.date(byAdding: .month, value: -1, to: currentDate)
        // swiftlint:disable:next force_unwrapping
        yearMonthDay.day = date!.daysInMonth - cal.component(.day, from: dob) + today
    } else {
        yearMonthDay.day = 0
        if yearMonthDay.month == 12 {
            yearMonthDay.year += 1
            yearMonthDay.month = 0
        }
    }

    return yearMonthDay
}

// swiftlint:disable:next large_tuple
func formatYMD(ymd: YearMonthDay) -> (String, String, String) {

    var year = ""
    var month = ""
    var day = ""

    if ymd.year > 1 {
        year = "\(ymd.year) years"
    } else if ymd.year == 1 {
        year = "\(ymd.year) year"
    }

    if ymd.month > 1 {
        month = "\(ymd.month) months"
    } else {
        month = "\(ymd.month) month"
    }

    if ymd.day > 1 {
        day = "\(ymd.day) days"
    } else {
        day = "\(ymd.day) day"
    }

    return (year, month, day)

}

func formatAge(_ dob: Date) -> String {

    let ymd = calculateAge(dob)
    let (year, month, day) = formatYMD(ymd: ymd)
    var age = ""

    if ymd.year != 0 { age += year }

    if ymd.month != 0 {
        if ymd.year != 0 {
            age += ", \(month)"
        } else {
            age += month
        }
    }

    if ymd.day != 0 {
        if ymd.month != 0 {
            age += ", \(day)"
        } else {
            if ymd.year != 0 {
                age += ", \(day)"
            } else {
                age += day
            }
        }
    }

    if age.isEmpty {
        age = "Newborn!"
    } else {
        age += " old"
    }

    return age
}

// Birthday is if there's only a year value and not months or days
func isBirthdayToday(_ dob: Date) -> Bool {
    let ymd = calculateAge(dob)
    var birthdayToday = false
    if ymd.year > 0, ymd.month == 0, ymd.day == 0 {
        birthdayToday = true
    }
    return birthdayToday
}
