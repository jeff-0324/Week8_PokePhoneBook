//
//  PhoneBook+CoreDataProperties.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/10/24.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profilesImage: Data?

}

extension PhoneBook : Identifiable {

}
