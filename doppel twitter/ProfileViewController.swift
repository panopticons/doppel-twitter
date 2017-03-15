//
//  ProfileViewController.swift
//  doppel twitter
//
//  Created by fer on 3/10/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var uTable: UITableView!
  @IBOutlet weak var tweetsNumber: UILabel!
  @IBOutlet weak var followingNumber: UILabel!
  @IBOutlet weak var followersNumber: UILabel!
  @IBOutlet weak var backImage: UIImageView!
  @IBOutlet weak var userImage: UIImageView!
  @IBOutlet weak var userT: UILabel!
  @IBOutlet weak var namet: UILabel!
  
  var tweets: [Tweet]!
  var user: User?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
      uTable.delegate = self
      uTable.dataSource = self
    
      self.userImage.layer.borderColor = UIColor.white.cgColor
      self.userImage.layer.borderWidth = 3
      if let profPicUrl = user?.profUrl
      {
        self.userImage.setImageWith(profPicUrl as URL)
      }
      if let bannerImageUrl = user?.bannerImageUrl
      {
        self.backImage.setImageWith(bannerImageUrl as URL)
      }
      self.userT.text = "@\(user!.userName!)"
      self.namet.text = user!.name! as? String
      self.navigationItem.title = user?.userName as! String
      
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = NumberFormatter.Style.decimal
      
      self.tweetsNumber.text = numberFormatter.string(from: NSNumber(value: user!.tweetsNum!))
      self.followersNumber.text = numberFormatter.string(from: NSNumber(value: user!.followers!))
      self.followingNumber.text = numberFormatter.string(from: NSNumber(value: user!.following!))
      
      TwitterClient.sharedInstance?.userTimeline(myUser: User._currentUser?.userName as! String, success: { (tweets: [Tweet]) in
        self.tweets = tweets
        self.uTable.reloadData()
        
        
      }, failure: { (error: NSError) in
        print(error.localizedDescription)
      })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "pCell", for: indexPath) as! TweetViewCell
    cell.tweet = tweets[indexPath.row]
    //cell.selectionStyle = .none
    
    return cell
  }
  
  
  @IBAction func backB(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
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
