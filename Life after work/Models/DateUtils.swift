//
//  DateUtils.swift
//  Life after work
//
//  Created by Lisa J on 1/14/25.
//

import Foundation

struct DateUtils {
    private var lastSavedDate: Date
    
    init(lastSavedDate: Date) {
        self.lastSavedDate = lastSavedDate
    }
    
    // Method to check if today's date is in a new week compared to the last saved date
    func isNewWeek() -> Bool {
        let calendar = Calendar.current
        let today = Date()
        
        // Extract the year and week number for today and the last saved date
        let todayWeek = calendar.component(.weekOfYear, from: today)
        let lastSavedWeek = calendar.component(.weekOfYear, from: lastSavedDate)
        let todayYear = calendar.component(.yearForWeekOfYear, from: today)
        let lastSavedYear = calendar.component(.yearForWeekOfYear, from: lastSavedDate)
        
        // Compare the year and week number to see if it is a new week
        return todayYear != lastSavedYear || todayWeek != lastSavedWeek
    }
    
    // Method to update the last saved date
    mutating func updateLastSavedDate() {
        lastSavedDate = Date.now
    }
}
