//
//  User+CoreDataProperties.swift
//  Clubster
//
//  Created by Adam Barson on 10/19/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user_code: String?
    @NSManaged public var subscriptions: NSSet?

}

// MARK: Generated accessors for subscriptions
extension User {

    @objc(addSubscriptionsObject:)
    @NSManaged public func addToSubscriptions(_ value: Club)

    @objc(removeSubscriptionsObject:)
    @NSManaged public func removeFromSubscriptions(_ value: Club)

    @objc(addSubscriptions:)
    @NSManaged public func addToSubscriptions(_ values: NSSet)

    @objc(removeSubscriptions:)
    @NSManaged public func removeFromSubscriptions(_ values: NSSet)

}
