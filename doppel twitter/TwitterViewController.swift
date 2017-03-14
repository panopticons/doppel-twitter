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
    count += 10
    
    TwitterClient.sharedInstance?.homeTimeline(count: count, success: { (tweets: [Tweet]) in
      self.tweets = tweets
      
      self.loading = false
      self.tweetsTable.reloadData()
      
      
    }, failure: { (error: NSError) in
      print(error.localizedDescription)
      self.loading = false
      print("LOADING")
    })
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    TwitterClient.sharedInstance?.homeTimeline(count: count, success: { (tweets: [Tweet]) in
      self.tweets = tweets
      self.tweetsTable.reloadData()
      
      for tweet in tweets {
        print(tweet.text)
      }
      
    }, failure: { (error: NSError) in
      print(error.localizedDescription)
    })
    
    tweetsTable.delegate = self
    tweetsTable.dataSource = self
    //tweetsTable.rowHeight = UITableViewAutomaticDimension
    //tweetsTable.estimatedRowHeight = 200
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onLogoutButton(_ sender: UIBarButtonItem) {
    TwitterClient.sharedInstance?.logout()    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tweets != nil {
      print("TEST")
      return tweets.count
    }
    else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetViewCell", for: indexPath) as! TweetViewCell
    cell.tweet = tweets[indexPath.row]
    //cell.selectionStyle = .none
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let dest = segue.destination as! UINavigationController
    let realDest = dest.topViewController as! TweetDetailsViewController
    
    realDest.name = (sender as! TweetViewCell).tName.text
    realDest.username = (sender as! TweetViewCell).tScreen.text
    realDest.date = (sender as! TweetViewCell).tDate.text
    realDest.content = (sender as! TweetViewCell).tContent.text
    realDest.picture = (sender as! TweetViewCell).tPic.image
    realDest.favorite = (sender as! TweetViewCell).fav
    realDest.retweet = (sender as! TweetViewCell).ret
    //realDest.reply = (sender as TweetViewCell).re
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
