//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/27/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tweets = [Tweet]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startNetworkActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNetworkActivity() {
        TwitterManager.sharedInstance?.homeTimeline(
        success: { (tweets: [Tweet]) in
                self.tweets = tweets
                for tweet in tweets {
                    print(tweet)
                }
                self.tableView.reloadData()
            }, failure: { (error: NSError) in
                print("Error loading tweets: \(error.localizedDescription)")
        })
    }

    // MARK:- Delegate callbacks
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
    }
    
    // MARK: - Actions
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterManager.sharedInstance?.logout()
    }

    // MARK: - Helpers
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableViewAutomaticDimension
tableView.rowHeight = 120
//        tableView.estimatedRowHeight = 120
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
