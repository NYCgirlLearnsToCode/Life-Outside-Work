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
    
    func save(categories: [Category]) {
        // TODO: figuring out whether to save the list of categories or something else
        
        //save button can save everything? or save speciifc fields..
    }
}
