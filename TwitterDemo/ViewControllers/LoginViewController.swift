//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/25/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "n1sYcM9yEWQaSf0jRaRZ1BA7u", consumerSecret: "Nm11u8ySaXZxha7BZSXhXiJ0d6H00vjJlHnXhim2Joq44KxMX2")
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil,
                                        success: { (requestToken: BDBOAuth1Credential?) in
                                            print("Got request token: \(requestToken?.token)")
                                            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=" + (requestToken?.token)!)
                                            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                        },
                                        failure: { (error: Error?) in
                                            print("error: \(error?.localizedDescription)")
                                        })
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
