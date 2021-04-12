//
//  DateHelper.swift
//  TapAndGo
//
//  Created by bastien lebrun on 12/04/2021.
//

import Foundation

class DateHelper {
    
    static func date(fromString: String) -> Date? {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        dateFormatter.locale = calendar.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: fromString) else { return nil }
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        return calendar.date(from:components)
    }
    
    static func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
