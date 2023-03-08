//
//  Cry+CoreDataProperties.swift
//  Cry Log
//
//  Created by Idris Mahamdi on 28/01/2023.
//
//

import Foundation
import CoreData


extension Cry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cry> {
        return NSFetchRequest<Cry>(entityName: "Cry")
    }

    @NSManaged public var when: String!
    @NSManaged public var location: String!
    @NSManaged public var reason: String!
    @NSManaged public var severity: String!

}

extension Cry : Identifiable {

}
