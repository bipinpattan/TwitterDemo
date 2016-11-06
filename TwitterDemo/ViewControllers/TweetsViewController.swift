//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/27/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, NewTweetViewControllerDelegate, TweetCellProtocol {
    var tweets = [Tweet]()
    @IBOutlet var tableView: UITableView!
    var loadingMoreView: ActivityView?
    var isMoreDataLoading = false
    var refreshControl = UIRefreshControl()
    var timelinePath: String!
    var vcTitle: String!
    var userScreenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startNetworkActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationViewController = segue.destination as! UINavigationController
        switch navigationViewController.topViewController {
        case is NewTweetViewController:
            let newTweetViewController = navigationViewController.topViewController as! NewTweetViewController
            newTweetViewController.delegate = self
            break

        case is TweetDetailsViewController:
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            let tweet = tweets[(indexPath?.row)!]
            let detailViewController = navigationViewController.topViewController as! TweetDetailsViewController
            detailViewController.tweet = tweet
            
        default:
            break
        }
    }
    
    // MARK:- Delegate callbacks
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    // MARK :- UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                startNetworkActivity()
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y:tableView.contentSize.height, width: tableView.bounds.size.width, height: ActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
            }
        }
    }
    
    func tweetCell(cell: TweetCell, wantsToShowPorfile withUser: User!) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.user = withUser
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    //MARK: NewTweetViewControllerDelegate
    func newTweetViewController(newTweetViewController ntvc: NewTweetViewController, didUpdateStatusWithTweet tweet: Tweet!) {
        print("New Tweet - \(tweet)")
        tweets.insert(tweet, at: 0)
        tableView.reloadData()
    }
    
    func newTweetViewControllerFailedToUpdateStatus(newTweetViewController: NewTweetViewController) {
        print("failed to update status")
    }
    
    func newTweetViewControllerCancelled(newTweetViewController: NewTweetViewController) {
        print("User cancelled new tweet")
    }
    
    // MARK: - Actions
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterManager.sharedInstance?.logout()
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        startNetworkActivity()
    }
    
    // MARK: - Helpers
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(self.refreshControl, at: 0)
        navigationItem.title = vcTitle
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: ActivityView.defaultHeight)
        loadingMoreView = ActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        // fix color of nav controller
        navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 63/255, green: 205/255, blue: 253/255, alpha: 1.0);
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    func startNetworkActivity() {
        self.loadingMoreView!.startAnimating()
        TwitterManager.sharedInstance?.timeline(path: timelinePath, screenName: userScreenName,
            success: { (tweets: [Tweet]) in
                self.tweets.append(contentsOf: tweets)
                self.isMoreDataLoading = false
                self.loadingMoreView!.stopAnimating()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }, failure: { (error: NSError) in
                print("Error loading tweets: \(error.localizedDescription)")
                self.loadingMoreView!.stopAnimating()
                self.isMoreDataLoading = false
                self.refreshControl.endRefreshing()                
        })
    }
    
}
