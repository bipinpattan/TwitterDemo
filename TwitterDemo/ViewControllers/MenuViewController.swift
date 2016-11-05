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
    private let titles = ["Red", "Green", "Blue"]
    var hamburgerViewController: HamburgerViewController!
    private var redNavigationController: UIViewController!
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
//        redNavigationController = storyBoard.instantiateViewController(withIdentifier: "RedNavigationController")
//        greenNavigationController = storyBoard.instantiateViewController(withIdentifier: "GreenNavigationController")
//        blueNavigationController = storyBoard.instantiateViewController(withIdentifier: "BlueNavigationController")
//        menuItems.append(redNavigationController)
//        menuItems.append(greenNavigationController)
//        menuItems.append(blueNavigationController)
//        hamburgerViewController.contentViewController = menuItems[0]
    }
    
    // Mark: - Delegates
    // Mark: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuTitleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
