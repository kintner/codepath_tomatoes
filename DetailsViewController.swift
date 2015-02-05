//
//  DetailsViewController.swift
//  rotten-tomatoes
//
//  Created by Christopher Kintner on 2/4/15.
//  Copyright (c) 2015 Christopher Kintner. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movie : NSDictionary!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        setBannerImage()
        tableView.reloadData()
    }
    
    func setBannerImage() {
        var thumbnailUrl = movie.valueForKeyPath("posters.thumbnail") as String
        var massiveUrl = thumbnailUrl.stringByReplacingOccurrencesOfString("_tmb", withString: "_org")
        bannerImageView.setImageWithURL(NSURL(string: massiveUrl))

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return initClearCell()
        } else  {
            return initDetailsCell();
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500.0
        } else {
            return 1000.0
        }
    }
    
    func initClearCell() -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    func initDetailsCell() -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
