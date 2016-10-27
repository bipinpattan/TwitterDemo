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
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        name = dictionary["name"] as? String
        tagLine = dictionary["description"] as? String
    }
    
    override var description: String {
        return "name: \(name)\nscreenName: \(screenName)\nprofileUrl: \(profileUrl)\ntagLine: \(tagLine)"
    }
}
