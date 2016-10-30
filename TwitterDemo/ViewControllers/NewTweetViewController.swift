//
//  NewTweetViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/30/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    let charsLeft = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK :- Actions
    @IBAction func onTweetButton(_ sender: AnyObject) {
        print("Tweet - \(tweetTextView.text!)")
        TwitterManager.sharedInstance?.updateStatus(statusText: tweetTextView.text!, success: { 
            print("Update status successful")
            }, failure: { (error: NSError) in
                print("Error updating status: \(error.localizedDescription)")
        })
    }

    @IBAction func onCancelButton(_ sender: AnyObject) {
    }
    
    // MARK :- Delegates
    // MARK - UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        
    }
    
    // MARK :- Helpers
    func setupUI() {
        self.navigationItem.title = "Compose 140"
        self.tweetTextView.delegate = self
        self.tweetTextView.text = ""
        self.tweetTextView.becomeFirstResponder()
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
