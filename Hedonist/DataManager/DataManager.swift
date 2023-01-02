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
        catch { print("Fetching error occured") }
        
        return fetched
    }
    
    
    func addPlace(address: String, category: String, descript: String, lat: Double, long: Double, name: String, phone: String, picture: String, smm: String, workhours: String) {
        let place = Place(context: persistentContainer.viewContext)
        place.address = address
        place.category = category
        place.date = Date()
        place.descript = descript
        place.id = UUID()
        place.lat = lat
        place.long = long
        place.name = name
        place.phone = phone
        place.picture = picture
        place.smm = smm
        place.workhours = workhours
        saveContext()
    }
    
    
    func deletePlace(object: Place) {
        let context = persistentContainer.viewContext
        context.delete(object)
    }
}
