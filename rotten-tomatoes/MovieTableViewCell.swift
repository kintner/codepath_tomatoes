//
//  MovieTableViewCell.swift
//  rotten-tomatoes
//
//  Created by Christopher Kintner on 2/3/15.
//  Copyright (c) 2015 Christopher Kintner. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
