//
//  DataManager.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation
import CoreData

final class DataManager {
    // MARK: - CoreData stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    // MARK: - Custom Implementation
    func fetchPlaces() -> [Place] {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        var fetched: [Place] = []
        
        do { fetched = try persistentContainer.viewContext.fetch(request) }
        catch { debugPrint("CoreData fetch error occured") }
        
        return fetched
    }
    
    
    func add(landmark: Landmark) {
        let place = Place(context: persistentContainer.viewContext)
        place.address = landmark.address
        place.category = landmark.category
        place.date = Date()
        place.descript = landmark.descript
        place.id = UUID()
        place.lat = landmark.lat ?? 0.0
        place.long = landmark.long ?? 0.0
        place.name = landmark.name
        place.phone = landmark.phone
        place.picture = landmark.image
        place.workhours = landmark.workhours
        saveContext()
    }
    
    
    func delete(object: Place) {
        let context = persistentContainer.viewContext
        context.delete(object)
        saveContext()
    }
}
