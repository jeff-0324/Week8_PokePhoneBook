//
//  CoreDataManger.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/9/24.
//

import UIKit
import CoreData

class CoreDataManger {
    
    // 싱글톤 형식으로 사용
    static let shared = CoreDataManger()
    
    // 코어 데이터 삭제
    //        lazy var persistentContainer: NSPersistentContainer = {
    //            let container = NSPersistentContainer(name: "pokePhoneBook")
    //
    //            // 기존 스토어 삭제
    //            if let storeURL = container.persistentStoreDescriptions.first?.url {
    //                let fileManager = FileManager.default
    //                if fileManager.fileExists(atPath: storeURL.path) {
    //                    do {
    //                        try fileManager.removeItem(at: storeURL)
    //                        print("Existing Core Data store deleted.")
    //                    } catch {
    //                        print("Failed to delete store: \(error)")
    //                    }
    //                }
    //            }
    //
    //            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    //                if let error = error as NSError? {
    //                    fatalError("Unresolved error \(error), \(error.userInfo)")
    //                }
    //            })
    //            return container
    //        }()
    //
    
    init() {}
    
    // CoreData 세팅
    var container: NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    var phoneBookEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: PhoneBook.className, in: context)
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // coreData에 create
    func createData(_ dataSource: DataSource) {
        guard let entity = phoneBookEntity else { return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: context)
        newPhoneBook.setValue(dataSource.name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(dataSource.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(dataSource.profilesImage, forKey: PhoneBook.Key.profilesImage)
        saveContext()
    }
    
    // coreData에서 read and fetch
    func fetchDataSource() -> [DataSource] {
        do {
            let phoneBooks = try context.fetch(PhoneBook.fetchRequest())
            return phoneBooks.map { phoneBook in
                DataSource(
                    name: phoneBook.name,
                    phoneNumber: phoneBook.phoneNumber,
                    profilesImage: phoneBook.profilesImage
                )
            }
        } catch {
            print("data read failure")
        }
        return []
    }
    
    // coreData에 update
    func updateData(_ dataSource: DataSource) {
        
        let fetchRequset = PhoneBook.fetchRequest()
        fetchRequset.predicate = NSPredicate(format: "name == %@", dataSource.name!)
        
        do {
            let result = try context.fetch(fetchRequset)
            
            for data in result {
                data.setValue(dataSource.name, forKey: PhoneBook.Key.name)
                data.setValue(dataSource.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
                data.setValue(dataSource.profilesImage, forKey: PhoneBook.Key.profilesImage)
            }
            try context.save()
            print("data update success")
        } catch {
            print("data update fail")
        }
    }
    
        // coreData에서 delete
        func deleteData(name: String?) {
            guard let name = name else { return }
            let fetchRequset = PhoneBook.fetchRequest()
            fetchRequset.predicate = NSPredicate(format: "name == %@", name)
    
            do {
                let result = try context.fetch(fetchRequset)
    
                for data in result {
                    self.context.delete(data)
                }
                try context.save()
                print("delete success")
            } catch {
                print("delete fail")
            }
        }
        
}
