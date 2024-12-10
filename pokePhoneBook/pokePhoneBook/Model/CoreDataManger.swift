//
//  CoreDataManger.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/9/24.
//

import UIKit
import CoreData

class CoreDataManger {
    
    var container: NSPersistentContainer!
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
    
    init() {
        coreDataSetup()
    }
    
    func coreDataSetup() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    // coreData에 create
    func createData(name: String, phoneNumber: String, profilesImage: Data) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(profilesImage, forKey: PhoneBook.Key.profilesImage)
        
        do {
            try self.container.viewContext.save()
            print("save success")
        } catch {
            print("save failure")
        }
    }
    
    // coreData에서 read
    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String,
                   let profilesImage = phoneBook.value(forKey: PhoneBook.Key.profilesImage) as? Data {
                    print("name: \(name), phoneNumber: \(phoneNumber), profileImage: \(profilesImage)")
                }
            }
        } catch {
            print("data read failure")
        }
    }
    
//    // coreData에 update
//    func updateData(currentName: String, updateName: String) {
//        
//        let fetchRequset = PhoneBook.fetchRequest()
//        fetchRequset.predicate = NSPredicate(format: "name == %@", currentName)
//        
//        do {
//            let result = try self.container.viewContext.fetch(fetchRequset)
//            
//            for data in result as [NSManagedObject] {
//                data.setValue(updateName, forKey: PhoneBook.Key.name)
//            }
//            try self.container.viewContext.save()
//            print("data update success")
//        } catch {
//            print("data update fail")
//        }
//    }
//    
//    // coreData에서 delete
//    func deleteData(name: String) {
//        
//        let fetchRequset = PhoneBook.fetchRequest()
//        fetchRequset.predicate = NSPredicate(format: "name == %@", name)
//        
//        do {
//            let result = try self.container.viewContext.fetch(fetchRequset)
//            
//            for data in result as [NSManagedObject] {
//                self.container.viewContext.delete(data)
//            }
//            try self.container.viewContext.save()
//            print("delete success")
//        } catch {
//            print("delete fail")
//        }
//    }
    
    // 코어 데이터의 값을 dataSource에 저장하는 메서드
    func fetchDataSource() -> [DataSource] {
        let fetchRequst: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
        do {
            let phoneBooks = try CoreDataManger.shared.container.viewContext.fetch(fetchRequst)
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
}

