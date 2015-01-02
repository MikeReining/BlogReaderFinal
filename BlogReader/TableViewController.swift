//
//  TableViewController.swift
//  BlogReader
//
//  Created by Michael Reining on 12/30/14.
//  Copyright (c) 2014 Mike Reining. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    var blogPosts = [BlogPost]()
    @IBOutlet var appsTableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestBlogPostsFromJSON("http://blog.teamtreehouse.com/api/get_recent_summary/")
        
    }
    
    func requestBlogPostsFromJSON(myurl: String) {
        let url = NSURL(string: myurl)
        let jsonData = NSData(contentsOfURL: url!)
        var error: NSError?
        
        let dataDictionary = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &error) as NSDictionary
        
        let blogPostArray: Array<NSDictionary> = dataDictionary.objectForKey("posts") as Array
        
        for bpDictionary: NSDictionary in blogPostArray {
            var blogPost = BlogPost(id: bpDictionary["id"] as Int)
            blogPost.title = bpDictionary["title"] as? String
            blogPost.author = bpDictionary["author"] as? String
            blogPost.thumbnail = bpDictionary["thumbnail"] as? String
            blogPost.date = bpDictionary["date"] as? String
            blogPost.url = bpDictionary["url"] as? NSURL
            blogPosts.append(blogPost)
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK: Table View Delegates
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        let blogPost = blogPosts[indexPath.row]
        
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
        
        return cell
    }
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
    
    //MARK: Table View Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let tableViewCell = sender as UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)!
        let blogPost = blogPosts[indexPath.row]
        
        if segue.identifier == "ShowDetail" {
            let viewController =  segue.destinationViewController as DetailViewController
            viewController.blogPostTitle = blogPost.title
            viewController.blogPostURL = blogPost.url!
        }
    }
    
    
    
    
}
