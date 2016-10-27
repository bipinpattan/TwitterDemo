//
//  TwitterManager.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/26/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterManager: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "n1sYcM9yEWQaSf0jRaRZ1BA7u", consumerSecret: "Nm11u8ySaXZxha7BZSXhXiJ0d6H00vjJlHnXhim2Joq44KxMX2")
    
    var loginSucess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()) {
        loginSucess = success
        loginFailure = failure
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil,
                                         success: { (requestToken: BDBOAuth1Credential?) in
                                            print("Got request token: \(requestToken?.token)")
                                            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=" + (requestToken?.token)!)
                                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            },
                                         failure: { (error: Error?) in
                                            print("error: \(error?.localizedDescription)")
                                            self.loginFailure?(error as! NSError)
        })
    }

    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken,
                                        success: { (accessToken:BDBOAuth1Credential?) in
                                            print("Access Token: \(accessToken?.token)")
                                            self.loginSucess?()
                                        },
                                        failure: { (error: Error?) in
                                            print("Error: \(error?.localizedDescription)")
                                        })
    }
    
    func currentAccount() {
        _ = get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
                               success: { (task: URLSessionDataTask?, response: Any?) in
                                print("Task: \(task) Account: \(response)")
                                let userDictionary = response as! NSDictionary
                                let user = User(dictionary: userDictionary)
                                print(user)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("Error: \(error.localizedDescription)")
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        _ = get("1.1/statuses/user_timeline.json", parameters: nil, progress: nil,
                                success: { (task: URLSessionDataTask, response: Any?) in
                                    let dictionaries = response as! [NSDictionary]
                                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                                    success(tweets)
                                },
                                failure: { (task:URLSessionDataTask?, error: Error) in
                                    failure(error as NSError)
                                })
    }
}