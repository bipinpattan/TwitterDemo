//
//  NewTweetViewController.swift
//  TwitterDemo
//
//  Created by Bipin Pattan on 10/30/16.
//  Copyright © 2016 Bipin Pattan. All rights reserved.
//

import UIKit

protocol NewTweetViewControllerDelegate : class {
    func newTweetViewController(newTweetViewController ntvc: NewTweetViewController, didUpdateStatusWithTweet tweet: Tweet!)
    func newTweetViewControllerFailedToUpdateStatus(newTweetViewController ntvc:  NewTweetViewController)
    func newTweetViewControllerCancelled(newTweetViewController ntvc: NewTweetViewController)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    weak var delegate: NewTweetViewControllerDelegate?
    
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
        TwitterManager.sharedInstance?.updateStatus(statusText: tweetTextView.text!, success: { (tweet: Tweet) in
                print("Update status successful")
                self.delegate?.newTweetViewController(newTweetViewController: self, didUpdateStatusWithTweet: tweet)
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error: NSError) in
                print("Error updating status: \(error.localizedDescription)")
                self.delegate?.newTweetViewControllerFailedToUpdateStatus(newTweetViewController: self)
                self.dismiss(animated: true, completion: nil)
        })
    }

    @IBAction func onCancelButton(_ sender: AnyObject) {
        delegate?.newTweetViewControllerCancelled(newTweetViewController: self)
        self.dismiss(animated: true, completion: nil)
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
