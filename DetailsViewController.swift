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
    
     override func viewWillAppear(animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clearColor()
        
        setBannerImage()
        tableView.reloadData()
        self.tableView.superview?.backgroundColor = UIColor.blackColor()

    }
    
    func setBannerImage() {
        var thumbnailUrl = movie.valueForKeyPath("posters.thumbnail") as String
        var massiveUrl = thumbnailUrl.stringByReplacingOccurrencesOfString("_tmb", withString: "_ori")
        NSLog(massiveUrl)
        bannerImageView.setImageWithURL(NSURL(string: massiveUrl))
        
//        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
//        
//        visualEffectView.frame = bannerImageView.bounds
//        
//        bannerImageView.addSubview(visualEffectView)

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return initClearCell()
        } else  {
            var cell = tableView.dequeueReusableCellWithIdentifier("details-view") as DetailsTableViewCell
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cell.initFromDict(movie)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var row = indexPath.row
        switch indexPath.row {
            case 0: return 500
            case 1: return 1000
            default: return 0
        }
    }
    
    func initClearCell() -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
