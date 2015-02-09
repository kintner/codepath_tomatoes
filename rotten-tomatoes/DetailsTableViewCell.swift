//
//  DetailsTableViewCell.swift
//  rotten-tomatoes
//
//  Created by Christopher Kintner on 2/4/15.
//  Copyright (c) 2015 Christopher Kintner. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    var movie: NSDictionary!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    func initFromDict(movie: NSDictionary) {
        self.movie = movie
        titleLabel.text = movie.valueForKeyPath("title") as NSString
        synopsisLabel.text = movie.valueForKey("synopsis") as NSString
        synopsisLabel.sizeToFit()
        
        
    }
    
    func desiredHeight() -> CGFloat {
        return synopsisLabel.bounds.height + 200
    }
    
}
