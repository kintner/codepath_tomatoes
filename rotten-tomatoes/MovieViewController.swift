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
    
    var errorView: UIView!
    var errorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        addErrorView()
        addRefreshView()
        
        loadData(true)
    }
    
    func addRefreshView() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        movieTableView.insertSubview(refreshControl, atIndex: 0)
        
    }
    
    func addErrorView() {
        
        errorView = UIView(frame: CGRect(x: 0, y: 64, width: 375, height: 40))
        var gradient = CAGradientLayer()
        gradient.frame = errorView.bounds
        
        var start = UIColor(red: 255, green: 255, blue: 255, alpha: 1).CGColor
        var end = UIColor(red: 55, green: 55, blue: 55, alpha: 1).CGColor
        
        gradient.colors = [UIColor.grayColor().CGColor, UIColor.blackColor().CGColor]
        errorView.layer.insertSublayer(gradient, atIndex: 0)
        
        errorText = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
        errorText.textColor = UIColor.whiteColor()
        errorText.textAlignment = NSTextAlignment.Center
        
        
        errorView.addSubview(errorText)
        
        movieTableView.superview?.insertSubview(errorView, atIndex: 1)
        errorView.hidden = true
    }
    
    func showErrorView(message: String) {
        errorView.alpha = 0
        errorView.hidden = false
        errorText.text = message
        
        UIView.animateWithDuration(0.5, delay:0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.errorView.alpha = 1
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.errorView.alpha = 0}, completion: nil)
    
    }
    
    func onRefresh() {
        loadData(false)
        
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

    
    func loadData(showHUD: Bool) {
        if showHUD {
            SVProgressHUD.show()
        }
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=30&country=us&apikey=cs5yg8qmkrmbrexqbrq4ds8f")!
        
        var request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: NSTimeInterval(5))
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
                if error != nil {
                self.loadDataError(error)
            } else {
                var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movies = responseDictionary["movies"] as NSArray
                self.movieTableView.reloadData()
            }
            
        }
    }
    
    
    func loadDataError(error: NSError!) {
        NSLog(error.localizedDescription)
        showErrorView(error.localizedDescription)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        movieTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as DetailsViewController;
        var path = movieTableView.indexPathForCell(sender as UITableViewCell)
        vc.movie = movies[path!.row] as NSDictionary
        vc.navigationItem.title = vc.movie.valueForKeyPath("title") as NSString
        
 
    }
    

}
