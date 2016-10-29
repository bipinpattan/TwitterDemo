//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/27/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var tweet: Tweet! {
        didSet {
            if let profileURL = tweet.user?.profileUrl {
                profileImageView.setImageWith(profileURL)
                profileImageView.layer.cornerRadius = 5
                profileImageView.clipsToBounds = true
            }
            if let userName = tweet.user?.name {
                userNameLabel.text = userName
            }
            if let screenName = tweet.user?.screenName {
                userHandleLabel.text = "@\(screenName)"
            }
            timeLabel.text = timeFormat(withDate: tweet.timeStamp)
            tweetTextLabel.text = tweet.text
        }
    }
    
    func timeFormat(withDate date: Date?) -> String {
        if let date = date {
            let elapsed = Int(Date().timeIntervalSince(date))
            if elapsed < 60 {
                return "\(elapsed) secs"
            } else if elapsed < 3600 {
                let mins = elapsed/60
                return mins == 1 ? "\(mins) min" : "\(mins) mins"
            } else if elapsed < 86400 {
                let hrs = (elapsed/3600)
                return hrs == 1 ? "\(hrs) hr" : "\(hrs) hrs"
            } else {
                let days = (elapsed/86400)
                return days == 1 ? "\(days) day" : "\(days) days"
            }
        }
        return ""
    }
}
