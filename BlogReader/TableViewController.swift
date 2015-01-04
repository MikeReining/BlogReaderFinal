//
//  TableViewController.swift
//  BlogReader
//
//  Created by Michael Reining on 12/30/14.
//  Copyright (c) 2014 Mike Reining. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController, APIControllerProtocol {
    var api = APIController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.api.delegate = self
        self.tableView.reloadData()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            self.api.requestBlogPostsFromJSON("http://blog.teamtreehouse.com/api/get_recent_summary/?count=20")
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        
        
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: API Controller Protocol
    
    func didReceiveAPIResults() {
        dispatch_async(dispatch_get_main_queue()) {
            println("dispatch in session there are \(self.api.blogPosts.count) blog posts")
            
            self.tableView.reloadData()
        }
        
    }
    
    
    //MARK: Table View Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.blogPosts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let blogPost = api.blogPosts[indexPath.row]
        
        cell.textLabel?.text = blogPost.title
        
        if let thumb = blogPost.thumbnail {
            let thumbURL = NSURL(string: thumb)
            let imageData = NSData(contentsOfURL: thumbURL!)
            let image = UIImage(data: imageData!)
            cell.imageView!.image = image
        } else {
            let image = UIImage(named: "treehouse.png")
            cell.imageView!.image = image
        }
        
        cell.detailTextLabel?.text = "\(blogPost.author!) - \(blogPost.blogPostAge(blogPost.date!))"
        println(blogPost.url)
        
        return cell
    }
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
    
    //MARK: Table View Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let blogPost = api.blogPosts[indexPath!.row]
            let detailVC = segue.destinationViewController as DetailViewController
            detailVC.blogPostTitle = blogPost.title!
            detailVC.blogPostUrl = blogPost.url!
        }
    }
    
    
    
    
}
