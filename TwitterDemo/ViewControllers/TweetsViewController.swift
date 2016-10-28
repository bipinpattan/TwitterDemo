//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/27/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startNetworkActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
    }
    
    func startNetworkActivity() {
        TwitterManager.sharedInstance?.homeTimeline(
        success: { (tweets: [Tweet]) in
                self.tweets = tweets
                for tweet in tweets {
                    print(tweet.text)
                }
            }, failure: { (error: NSError) in
                print("Error loading tweets: \(error.localizedDescription)")
        })
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterManager.sharedInstance?.logout()
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
