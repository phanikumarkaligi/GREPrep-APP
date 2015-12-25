//
//  GREList+CoreDataProperties.swift
//  GREPrep
//
//  Created by Deepthi Kaligi on 24/12/2015.
//  Copyright © 2015 TeamTreeHouse. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GREList {

    @NSManaged var word: String?
    @NSManaged var meaning: String?

}
