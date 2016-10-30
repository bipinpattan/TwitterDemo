//
//  TweetDetailsViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/30/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
