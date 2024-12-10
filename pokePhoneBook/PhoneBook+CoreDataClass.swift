//
//  PhoneBook+CoreDataClass.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/10/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let profilesImage = "profilesImage"
    }
}
