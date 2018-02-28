//
//  Country+CoreDataProperties.swift
//  FetchRequestInFourWays
//
//  Created by Mazharul Huq on 2/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var area: Int32
    @NSManaged public var capital: String?
    @NSManaged public var name: String?
    @NSManaged public var population: Int32

}
