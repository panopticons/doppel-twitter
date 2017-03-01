//
//  TwitterViewController.swift
//  doppel twitter
//
//  Created by fer on 2/25/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tweets: [Tweet]!
  var count = 20
  var loading = false
  
  @IBOutlet weak var tweetsTable: UITableView!
  
  func refreshControlAction(refreshControl: UIRefreshControl) {
    count = 20
    
    TwitterClient.sharedInstance?.homeTimeline(count: count, success: { (tweets: [Tweet]) in
      self.tweets = tweets
      self.tweetsTable.reloadData()
      refreshControl.endRefreshing()
      
    }, failure: { (error: NSError) in
      print(error.localizedDescription)
      refreshControl.endRefreshing()
    })
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (!loading) {
      
      let scrollViewContentHeight = tweetsTable.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - tweetsTable.bounds.size.height
      
      if(scrollView.contentOffset.y > scrollOffsetThreshold && tweetsTable.isDragging) {
        loading = true
        loadMoreData()
      }
    }
  }
  
  func loadMoreData() {
    count += 20
    
    TwitterClient.sharedInstance?.homeTimeline(count: count, success: { (tweets: [Tweet]) in
      self.tweets = tweets
      
      self.tweetsTable.reloadData()
      
    }, failure: { (error: NSError) in
      print(error.localizedDescription)

      self.loading = false
    })
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    TwitterClient.sharedInstance?.homeTimeline(count: count, success: { (tweets: [Tweet]) in
      self.tweets = tweets
      self.tweetsTable.reloadData()
      
    }, failure: { (error: NSError) in
      print(error.localizedDescription)
    })
    
    tweetsTable.rowHeight = UITableViewAutomaticDimension
    tweetsTable.estimatedRowHeight = 200
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onLogoutButtton(_ sender: Any) {
    TwitterClient.sharedInstance?.logout()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tweets != nil {
      return tweets.count
    }
    else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetViewCell", for: indexPath) as! TweetViewCell
    
    cell.tweet = tweets[indexPath.row]
    cell.selectionStyle = .none
    
    return cell
  }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
