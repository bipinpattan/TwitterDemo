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
    
    static let userDidLogoutNotification = NSNotification.Name("userDidLogoutNotification")
    static let homeTimelinePath = "home_timeline.json"
    static let mentionsTimelinePath = "mentions_timeline.json"
    static let userTimelinePath = "user_timeline.json"
    
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
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: TwitterManager.userDidLogoutNotification, object: nil)
    }

    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken,
                                        success: { (accessToken:BDBOAuth1Credential?) in
                                            print("Access Token: \(accessToken?.token)")
                                            
                                            self.currentAccount(
                                                success: { (user: User) in
                                                    User.currentUser = user
                                                    self.loginSucess?()
                                                },
                                                failure: { (error: NSError) in
                                                    self.loginFailure?(error)
                                            })
                                        },
                                        failure: { (error: Error?) in
                                            print("Error: \(error?.localizedDescription)")
                                        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        _ = get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
                               success: { (task: URLSessionDataTask?, response: Any?) in
                                print("Task: \(task) Account: \(response)")
                                let userDictionary = response as! NSDictionary
                                let user = User(dictionary: userDictionary)
                                print(user)
                                success(user)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("Error: \(error.localizedDescription)")
                failure(error as NSError)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        _ = get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
                                success: { (task: URLSessionDataTask, response: Any?) in
                                    let dictionaries = response as! [NSDictionary]
                                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                                    success(tweets)
                                },
                                failure: { (task:URLSessionDataTask?, error: Error) in
                                    failure(error as NSError)
                                })
    }

    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        _ = get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil,
                success: { (task: URLSessionDataTask, response: Any?) in
                    let dictionaries = response as! [NSDictionary]
                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                    success(tweets)
            },
                failure: { (task:URLSessionDataTask?, error: Error) in
                    failure(error as NSError)
        })
    }
    
    func userTimeline(screenName: String!, success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        _ = get("1.1/statuses/user_timeline.json", parameters: ["screen_name" : screenName], progress: nil,
                success: { (task: URLSessionDataTask, response: Any?) in
                    let dictionaries = response as! [NSDictionary]
                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                    success(tweets)
            },
                failure: { (task:URLSessionDataTask?, error: Error) in
                    failure(error as NSError)
        })
    }
    
    func timeline(path: String!, screenName: String?, success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        var params = [ String : String]()
        if let screenName = screenName {
            params = ["screen_name" : screenName]
        }
        let urlPath = "1.1/statuses/\(path!)"
        _ = get(urlPath, parameters: params, progress: nil,
                success: { (task: URLSessionDataTask, response: Any?) in
                    let dictionaries = response as! [NSDictionary]
                    let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
                    success(tweets)
            },
                failure: { (task:URLSessionDataTask?, error: Error) in
                    failure(error as NSError)
        })
    }
    
    func updateStatus(statusText status: String!, success: @escaping (Tweet) -> (), failure: @escaping (NSError) -> ()) {
        let queryParams = ["status" : status!];
        _ = post("1.1/statuses/update.json", parameters: queryParams, progress: nil,
                 success: { (task: URLSessionDataTask, response: Any?) in
                    let dictionaries = response as! NSDictionary
                    let tweets = Tweet.tweetsWithArray(dictionaries: [dictionaries])
                    print(tweets)
                    success(tweets[0])
            },
                 failure: { (task:URLSessionDataTask?, error: Error) in
                    failure(error as NSError)
        })
    }
}
