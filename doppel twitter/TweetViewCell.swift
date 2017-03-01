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

  var tweet: Tweet! {
    didSet{
      tName.text = self.tweet.user?.name! as String?
      tScreen.text = ("@\(self.tweet.user!.userName!)")
      if let imageURL = self.tweet.user?.profUrl
      {
        tPic.setImageWith(imageURL as URL)
      }
    tContent.text = self.tweet.text! as String?
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
