// Playground - noun: a place where people can play

import Cocoa

func requestBlogPostsFromJSON(myurl: String) {
    let url = NSURL(string: myurl)
    let jsonData = NSData(contentsOfURL: url!)
    
    var error: NSError?
    
    let dataDictionary = NSJSONSerialization.JSONObjectWithData(jsonData!, options: nil, error: &error) as NSDictionary
    
    let blogPostArray: Array<NSDictionary> = dataDictionary.objectForKey("posts") as Array

requestBlogPostsFromJSON("http://blog.teamtreehouse.com/api/get_recent_summary/?count=20")


var test = 5

