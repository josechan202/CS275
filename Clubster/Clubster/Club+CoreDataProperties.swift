//
//  Club+CoreDataProperties.swift
//  Clubster
//
//  Created by Adam Barson on 10/19/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation
import CoreData


extension Club {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var club_code: String?
    @NSManaged public var name: String?

}
