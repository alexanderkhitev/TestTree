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

public class DataDownloader {
    
    public func download() {
        let urlString = "https://money.yandex.ru/api/categories-list"
        Alamofire.request(.GET, urlString).responseJSON { (response) in
            if response.result.isSuccess {
                guard let result = response.result.value as? [[String : AnyObject]] else { return }
//                print(result, result.count)
                result.forEach({ (dictionary) in
                    print(dictionary, "end")
                })
                self.save(result)
            } else {
                print(response.result.error?.localizedDescription)
            }
        }
    }
    
    private func save(json: [[String : AnyObject]]) {
        
    }
    
}