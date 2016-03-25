//
//  CategoryTableViewController.swift
//  TestTree
//
//  Created by Alexsander  on 3/24/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CategoryTableViewController: UITableViewController, DataDownloaderDelegate {
    
    // MARK: - var and let
    private let dataDownloader = DataDownloader()
    private let refreshControll = UIRefreshControl()
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var categories = [Category]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        setSetting()
        firstLaunch()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - functions
    private func firstLaunch() {
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch")
        if firstLaunch == false {
            dataDownloader.download(tableView)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
        }
    }
    
    private func setSetting() {
        refreshControll.addTarget(self, action: #selector(self.updateData), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControll)
        dataDownloader.delegate = self
    }
    
    @objc private func updateData() {
        dataDownloader.update()
        refreshControll.endRefreshing()
    }
    
    // MARK: - FetchedResultController
    
    private func fetchRequest() {
        let fetchRequest = NSFetchRequest(entityName: "Category")
        let sortDescriptor = NSSortDescriptor(key: "remoteID", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let dataStack = appDelegate.dataStack
        do {
            try categories = (dataStack.mainContext.executeFetchRequest(fetchRequest) as? [Category])!
        } catch let error as NSError {
            print(error.localizedDescription, error.userInfo)
        }
        tableView.reloadData()
    }
    
    // MARK: - data downloader
    func dataDownloaderDidLoad() {
        fetchRequest()
        print("dataDownloaderDidLoad")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath)

        // Configure the cell...
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.title

        return cell
    }
    
    // MARK: - for navigation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCategory = categories[indexPath.row]
        let subTVC = InterfaceUtility.mainStoryboard.instantiateViewControllerWithIdentifier("SubTableViewController") as! SubTableViewController
        subTVC.category = currentCategory
        showViewController(subTVC, sender: self)
    }

   
}
