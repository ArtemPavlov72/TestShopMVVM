//
//  StorageManager.swift
//  TestShopMVVM
//
//  Created by Артем Павлов on 17.03.2023.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserRegistrationData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = persistentContainer.viewContext
    }
    
    func fetchUsers(completion: (Result<[NewUser], Error>) -> Void) {
        let fetchRequest = NewUser.fetchRequest()
        do {
            let users = try viewContext.fetch(fetchRequest)
            completion(.success(users))
        } catch let error {
            completion(.failure(error))
        }
    }
        
    //MARK: - Private Methods of UserData
    func saveUser(name: String, secondName: String, mail: String) {
        let user = NewUser(context: viewContext)
        user.firstName = name
        user.secondName = secondName
        user.mail = mail
        saveContext()
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
