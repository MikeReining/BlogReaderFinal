//
//  DetailViewController.swift
//  BlogReader
//
//  Created by Michael Reining on 1/2/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var blogPostTitle: String?
    var blogPostURL: NSURL = NSURL()
    
    @IBOutlet weak var showTitle: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = blogPostTitle
        //        webView?.loadRequest(NSURLRequest(URL: blogPostUrl))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}