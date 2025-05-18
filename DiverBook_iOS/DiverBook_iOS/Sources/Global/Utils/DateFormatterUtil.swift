//
//  DateFormatterUtil.swift
//  DiverBook_iOS
//
//  Created by jun on 5/18/25.
//

import Foundation

enum DateFormatterUtil {
    static func formatFoundDate(_ raw: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: raw) else {
            return "-"
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy. MM. dd"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        return outputFormatter.string(from: date)
    }

    static func formatToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy. MM. dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: Date())
    }
}
