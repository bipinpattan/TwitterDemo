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
//            profileImageView.setImageWith(tweet.)
            tweetTextLabel.text = tweet.text
        }
    }
    
}
