//
//  ProfileViewController.swift
//  doppel twitter
//
//  Created by fer on 3/10/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

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
      //Set up UI
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
      
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = NumberFormatter.Style.decimal
      
      self.tweetsNumber.text = numberFormatter.string(from: NSNumber(value: user!.tweetsNum!))
      self.followersNumber.text = numberFormatter.string(from: NSNumber(value: user!.followers!))
      self.followingNumber.text = numberFormatter.string(from: NSNumber(value: user!.following!))
      
      //Get user tweets
      TwitterClient.sharedInstance?.userTimeline(myUser: user!.userName as! String, success: { (tweets: [Tweet]) in
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
