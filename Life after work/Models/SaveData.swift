//
//  SaveData.swift
//  Life after work
//
//  Created by Lisa J on 1/16/25.
//

import Foundation

struct SaveData: Codable {
    var elements: [Category]
    var lastSavedDate: Date?
}
