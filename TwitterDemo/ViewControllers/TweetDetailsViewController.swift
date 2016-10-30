//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/30/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    var tweet: Tweet?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK :- Actions
    @IBAction func onFavoriteButton(_ sender: AnyObject) {
    }
    
    @IBAction func onRepyButton(_ sender: AnyObject) {
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
    }
     
    @IBAction func onDoneButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK :- Helpers
    func setupUI() {
        if let profileURL = tweet?.user?.profileUrl {
            profileImageView.setImageWith(profileURL)
            profileImageView.layer.cornerRadius = 10
            profileImageView.clipsToBounds = true
        }
        if let userName = tweet?.user?.name {
            userNameLabel.text = userName
        }
        if let userHandle = tweet?.user?.screenName {
            userHandleLabel.text = "@\(userHandle)"
        }
        if let text = tweet?.text {
            tweetTextLabel.text = text
        }
        retweetsLabel.text = String(describing: tweet!.retweetCount)
        favoritesLabel.text = String(describing: tweet!.favoritesCount)
        
        replyButton.setImage(UIImage(named: "reply"), for: .normal)
        retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
        favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
    }
}
