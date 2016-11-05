//
//  HamburgerViewController.swift
//  HamburgerApp
//
//  Created by Bipin Pattan on 11/3/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private let titles = ["Profile", "Mentions"]
    private let images = [UIImage(named:"profile.png"),
                          //UIImage(named:"timeline.png"),
                          UIImage(named:"mentions.png")]
    var hamburgerViewController: HamburgerViewController!
    private var tweetsNavigationController: UINavigationController!
    private var mentionsNavigationController: UINavigationController!
    private var greenNavigationController: UIViewController!
    private var blueNavigationController: UIViewController!
    private var menuItems: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        tweetsNavigationController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationViewController") as! UINavigationController
        menuItems.append(tweetsNavigationController)
        let tweetsVC = tweetsNavigationController.viewControllers[0] as! TweetsViewController
        tweetsVC.timelinePath = TwitterManager.homeTimelinePath

        mentionsNavigationController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationViewController") as! UINavigationController
        menuItems.append(mentionsNavigationController)

        hamburgerViewController.contentViewController = menuItems[0]
    }
    
    // Mark: - Delegates
    // Mark: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuTitleLabel.text = titles[indexPath.row]
        cell.menuImageView.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let navController = menuItems[indexPath.row] as! UINavigationController
        let tweetsVC = navController.viewControllers[0] as! TweetsViewController
        if indexPath.row == 0 {
            tweetsVC.timelinePath = TwitterManager.homeTimelinePath
        }
        else if indexPath.row == 1 {
            tweetsVC.timelinePath = TwitterManager.mentionsTimelinePath
        }
        hamburgerViewController.contentViewController = menuItems[indexPath.row]
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
