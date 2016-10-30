//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/26/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileURL: URL?
    var user: User?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        let timeStampString = dictionary["created_at"] as? String
        if let userDictionary = dictionary["user"] as? NSDictionary {
            user = User(dictionary: userDictionary)
        }
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    override var description: String {
        return "Tweet: \(text)\ntimeStamp: \(timeStamp)\nretweetCount: \(retweetCount)\nfavoritesCount: \(favoritesCount)\nprofileURL: \(profileURL)\nuser: \(user)"
    }
}
