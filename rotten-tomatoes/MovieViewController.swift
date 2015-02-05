//
//  MovieViewController.swift
//  rotten-tomatoes
//
//  Created by Christopher Kintner on 2/3/15.
//  Copyright (c) 2015 Christopher Kintner. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    
    var movies: NSArray = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func onRefresh() {
        loadData()
         refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = movieTableView.dequeueReusableCellWithIdentifier("movie-cell") as MovieTableViewCell
        var movie = movies[indexPath.row] as NSDictionary
        
        cell.movieTitle.text = movie.valueForKeyPath("title") as? String
        cell.movieDescription.text = movie.valueForKeyPath("synopsis") as? String
 
        var imageUrl = NSURL(string: (movie.valueForKeyPath("posters.thumbnail") as String))
        cell.posterImageView.setImageWithURL(imageUrl)
            
        return cell
        
        
    }
    
    func loadData() {
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=30&country=us&apikey=cs5yg8qmkrmbrexqbrq4ds8f")!
        
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = responseDictionary["movies"] as NSArray
            self.movieTableView.reloadData()
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        movieTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as DetailsViewController;
        var path = movieTableView.indexPathForCell(sender as UITableViewCell)
        vc.movie = movies[path!.row] as NSDictionary
 
    }
    

}
