//
//  DataDownloader.swift
//  TestTree
//
//  Created by Alexsander  on 3/24/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import Foundation
import Alamofire
import Sync
import DATAStack
import MBProgressHUD
import CoreData

@objc public protocol DataDownloaderDelegate {
    optional func dataDownloaderDidLoad()
}

public class DataDownloader {
    
    // MARK: - var and let
    public weak var delegate: DataDownloaderDelegate?
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private var progress: MBProgressHUD!
    
    // MARK: - functions
    
    public func download(view: UIView?) {
        progress = MBProgressHUD.showHUDAddedTo(view, animated: true)
        progress.removeFromSuperViewOnHide = true
        update()
    }
    
    public func update() {
        dispatch_async(dispatch_get_main_queue()) {
            let urlString = "https://money.yandex.ru/api/categories-list"
            Alamofire.request(.GET, urlString).responseJSON { (response) in
                if response.result.isSuccess {
                    guard let result = response.result.value as? [[String : AnyObject]] else { return }
                    self.save(result)
                } else {
                    print(response.result.error?.localizedDescription)
                }
            }
        }
    }
    
    private func save(json: [[String : AnyObject]]) {
        let dataStack = appDelegate.dataStack
        print(json.count)
        Sync.changes(json, inEntityNamed: "Category", dataStack: dataStack) { (error) in
            if error == nil {
                print("success")
                if self.progress != nil {
                    self.progress.hide(true)
                }
                self.delegate?.dataDownloaderDidLoad?()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
}