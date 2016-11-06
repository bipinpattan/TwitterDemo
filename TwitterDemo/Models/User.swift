//
//  User.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/26/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagLine: String?
    var bannerUrl: URL?
    var followersCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    var dictionary: NSDictionary?
    static var kUserDataKeyName = "currentUserData"
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        let bannerUrlString = dictionary["profile_banner_url"] as? String
        if let bannerUrlString = bannerUrlString {
            bannerUrl = URL(string: bannerUrlString)
        }
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        name = dictionary["name"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    override var description: String {
        return "name: \(name)\nscreenName: \(screenName)\nprofileUrl: \(profileUrl)\ntagLine: \(tagLine)\nbannerUrl: \(bannerUrl)\ntweets: \(tweetCount)\nfollowers: \(followersCount)\nfollowing: \(followingCount)"
    }
    
    static var _currentUser: User?
    
    static var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: kUserDataKeyName) as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                print(user.dictionary!)
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: kUserDataKeyName)
            }
            else {
                defaults.set(nil, forKey: kUserDataKeyName)
            }
            defaults.synchronize()
        }
    }
    
}
