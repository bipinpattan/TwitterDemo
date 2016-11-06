//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 11/5/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var tweetsNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var followersNumberLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    var tweetsViewController: TweetsViewController!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        navigationItem.title = user?.screenName
        navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 63/255, green: 205/255, blue: 253/255, alpha: 1.0);
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        nameLabel.text = user?.name
        if let screenName = user?.screenName {
            handleLabel.text = "@\(screenName)"
        }
        if let profileURL = user?.profileUrl {
            userImageView.setImageWith(profileURL)
            userImageView.layer.cornerRadius = 5
            userImageView.clipsToBounds = true
        }
        if let bannerURL = user?.bannerUrl {
            backgroundImageView.setImageWith(bannerURL)
        }
        tweetsNumberLabel.text = numbersLabel(num: user?.tweetCount)
        followingNumberLabel.text = numbersLabel(num: user?.followingCount)
        followersNumberLabel.text = numbersLabel(num: user?.followersCount)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        tweetsViewController = storyBoard.instantiateViewController(withIdentifier: "TweetsViewController") as! TweetsViewController
        tweetsViewController.timelinePath = TwitterManager.userTimelinePath
        tweetsViewController.userScreenName = user?.screenName
        tweetsViewController.willMove(toParentViewController: self)
        contentView.addSubview(tweetsViewController.view)
        tweetsViewController.didMove(toParentViewController: self)
        view.layoutIfNeeded()
    }
    
    func numbersLabel(num: Int?) -> String {
        if let num = num {
            if num < 999 {
                return "\(num)"
            }
            else if num < 1000000 {
                return "\(num/1000)k"
            }
            return "\(num/1000000)m"
        }
        return "0"
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
