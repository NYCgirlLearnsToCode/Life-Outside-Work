//
//  PersistenceHelper.swift
//  Life after work
//
//  Created by Lisa J on 11/7/24.
//
import Foundation

struct PersistenceHelper<T: Codable> {

    private let jsonFileName: String
    
    private var jsonUrl: URL {
        return jsonFilePathFromDocumentsDirectory(filename: jsonFileName)
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // TODO: create the json version of this file
    func loadData() throws -> SaveData? {
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(SaveData.self, from: jsonData)
        } catch {
            print("error decoding json data: \(error)")
            return nil
        }
    }
    
    func deleteItems()  throws {
        do {
            let emptyData = SaveData(elements: [], lastSavedDate: nil)
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(emptyData)
            try jsonData.write(to: jsonUrl)
            print("successfully deleted data by writing empty data")
        } catch {
            print("error deleting data: \(error)")
        }
    }
    
    func save(newData: SaveData) throws {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(newData)
            try jsonData.write(to: jsonUrl)
        } catch {
            print("error encoding data: \(error)")
        }
    }
    
    private func jsonFilePathFromDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(jsonFileName)
    }
    
    init(jsonFileName: String) {
        self.jsonFileName = jsonFileName
        saveDefaultDataIfNeeded()
    }
    
    private func saveDefaultDataIfNeeded() {
        guard !FileManager.default.fileExists(atPath: jsonUrl.path) else {
            return
        }
        
        let defaultSaveData = SaveData(elements: [], lastSavedDate: nil)
        do {
            try save(newData: defaultSaveData)
            print("Default data saved.")
        } catch {
            print("Error saving default data: \(error)")
        }
    }
}

struct CategoryPersistenceHelper {
    static let manager = CategoryPersistenceHelper()
    
    private let persistenceJsonHelper = PersistenceHelper<SaveData>(jsonFileName: "lifeOutsideWork.json")
    
    func saveJson(saveData: SaveData, completion: () -> Void, onFailure: () -> Void) {
        do {
            try persistenceJsonHelper.save(newData: saveData)
            completion()
        } catch {
            onFailure()
            print("cannot save new categories with error: \(error)")
        }
    }
    
    func loadData() -> SaveData? {
        do {
            return try persistenceJsonHelper.loadData()
        } catch {
            print(" error loading data")
            return nil
        }
    }
    
    func deleteItems() {
        do {
            try persistenceJsonHelper.deleteItems()
        } catch {
            print("could not delete")
        }
    }
}
