//
//  Category+CoreDataProperties.swift
//  TestTree
//
//  Created by Alexsander  on 3/25/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Category {

    @NSManaged var title: String?
    @NSManaged var remoteID: NSNumber?
    @NSManaged var subs: NSSet?

}
