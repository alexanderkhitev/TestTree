//
//  Subs+CoreDataProperties.swift
//  TestTree
//
//  Created by Alexsander  on 3/24/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Subs {

    @NSManaged var id: NSNumber?
    @NSManaged var title: String?
    @NSManaged var remoteID: String?
    @NSManaged var category: NSManagedObject?

}
