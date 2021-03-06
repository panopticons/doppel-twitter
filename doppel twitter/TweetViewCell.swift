//
//  TweetViewCell.swift
//  doppel twitter
//
//  Created by fer on 2/28/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

  @IBOutlet weak var tPic: UIImageView!
  @IBOutlet weak var tName: UILabel!
  @IBOutlet weak var tContent: UILabel!
  @IBOutlet weak var tScreen: UILabel!
  @IBOutlet weak var tDate: UILabel!
  @IBOutlet weak var tReplyI: UIImageView!
  @IBOutlet weak var tRetweetI: UIImageView!
  @IBOutlet weak var tFaveI: UIImageView!
  var ret: String!
  var fav: String!

  var tweet: Tweet! {
    didSet{
      tName.text = self.tweet.user?.name! as String?
      tScreen.text = ("@\(self.tweet.user!.userName!)")
      if let imageURL = self.tweet.user?.profUrl
      {
        tPic.setImageWith(imageURL as URL)
      }
    tContent.text = self.tweet.text! as String?
    tDate.text = String(describing: self.tweet.time!)
    tReplyI.image = UIImage(named: "reply-icon.png")
    tFaveI.image = UIImage(named: "favor-icon.png")
    tRetweetI.image = UIImage(named: "retweet-icon.png")
    ret = String(tweet.retweetCount)
    fav = String(tweet.favoritesCount)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
