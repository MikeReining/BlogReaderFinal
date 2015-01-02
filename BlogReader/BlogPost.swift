//
//  BlogPostDataModel.swift
//  BlogReader
//
//  Created by Michael Reining on 1/1/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class BlogPost: NSObject {
    var id: Int
    var title: String?
    var author: String?
    var thumbnail: String?
    var date: String?
    var url: NSURL?
    
    init(id: Int) {
        self.id = id
        super.init()
    }
    
    func simpleDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let tempDate = dateFormatter.dateFromString(date!)
        dateFormatter.dateFormat = "EE MMM dd, y"
        return dateFormatter.stringFromDate(tempDate!)
    }
    
    func blogPostAge(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let tempDate = dateFormatter.dateFromString(date)
        return timeAgoSinceDate(tempDate!, true)
    }

    
    
}

