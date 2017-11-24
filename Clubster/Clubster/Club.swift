//
//  Club+CoreDataClass.swift
//  Clubster
//
//  Created by Adam Barson on 10/19/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation
import CoreData

@objc(Club)
public class Club: NSManagedObject {

}


public class TempClub {
    public var name: String?
    public var club_code: String?
    public var subbed: Bool?
    init(name: String, club_code: String) {
        self.name = name
        self.club_code = club_code
    }
}
