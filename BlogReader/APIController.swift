//
//  APIController.swift
//  BlogReader
//
//  Created by Michael Reining on 1/4/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults()
}

class APIController {
    var blogPosts = [BlogPost]()
    var delegate: APIControllerProtocol?
    
    init() {
    }
    
    func requestBlogPostsFromJSON(myurl: String) {
        let url = NSURL(string: myurl)
        let jsonData = NSData(contentsOfURL: url!)
        var error: NSError?
        
        let dataDictionary = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &error) as NSDictionary
        
        let blogPostArray: Array<NSDictionary> = dataDictionary.objectForKey("posts") as Array
        println(url!)
        
        for bpDictionary: NSDictionary in blogPostArray {
            var blogPost = BlogPost(id: bpDictionary["id"] as Int)
            blogPost.title = bpDictionary["title"] as? String
            blogPost.author = bpDictionary["author"] as? String
            blogPost.thumbnail = bpDictionary["thumbnail"] as? String
            blogPost.date = bpDictionary["date"] as? String
            blogPost.url = NSURL(string: bpDictionary["url"] as String)
            self.blogPosts.append(blogPost)
        }
        println("created \(self.blogPosts.count) blog posts")

        
        self.delegate?.didReceiveAPIResults()
        println("received \(self.blogPosts.count) blog posts")

        
    }
    
    
}