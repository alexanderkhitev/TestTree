//
//  SubTableViewController.swift
//  TestTree
//
//  Created by Alexsander  on 3/25/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class SubTableViewController: UITableViewController {
    
    // MARK: - var and let
    var category: Category!
    private var subCategories = [Subs]()
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        if category != nil {
            subCategories = Array(category.subs!) as! [Subs]
            subCategories.sortInPlace({ (firstSub, secondSub) -> Bool in
                if firstSub.title < secondSub.title {
                    return true
                } else {
                    return false
                }
            })
            print(subCategories.count)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subCell", forIndexPath: indexPath)

        // Configure the cell...
        let category = subCategories[indexPath.row]
        cell.textLabel?.text = category.title

        return cell
    }
}
