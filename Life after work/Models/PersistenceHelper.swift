//
//  PersistenceHelper.swift
//  Life after work
//
//  Created by Lisa J on 11/7/24.
//
import Foundation

struct PersistenceHelper<T: Codable> {
    private let fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(filename: fileName)
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func deleteItems() throws {
        var elements = try getObjects()
        elements = [T]()
        
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func save(newElements: [T]) throws {
        var elements = try getObjects()
        elements = newElements
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    private func filePathFromDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(fileName)
    }
    
    init(fileName: String) {
        self.fileName = fileName
    }
}

struct CategoryPersistenceHelper {
    static let manager = CategoryPersistenceHelper()
    
    private let persistenceHelper = PersistenceHelper<Category>(fileName: "lifeOutsideWorkSelectedCategories.plist")
    
    func save(categories: [Category], completion: ([Category]) -> Void, onFailure: () -> Void) {
        do {
            try persistenceHelper.save(newElements: categories)
            completion(categories)
        } catch {
            onFailure()
            print("cannot save new categories with error: \(error)")
        }
    }
    
    func getItems() -> [Category]? {
        do {
            return try persistenceHelper.getObjects()
        } catch {
            print("cannot get categories")
            return nil
        }
    }
    
    func deleteItems() {
        do {
            try persistenceHelper.deleteItems()
        } catch {
            print("could not delete")
        }
    }
}
