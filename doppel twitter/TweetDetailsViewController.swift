//
//  TweetDetailsViewController.swift
//  doppel twitter
//
//  Created by fer on 3/10/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

  @IBOutlet weak var nameL: UILabel!
  @IBOutlet weak var usernameL: UILabel!
  @IBOutlet weak var picB: UIImageView!
  @IBOutlet weak var contentL: UILabel!
  @IBOutlet weak var retweetValL: UILabel!
  @IBOutlet weak var favoriteValL: UILabel!
  @IBOutlet weak var dateL: UILabel!
  
  var name: String!
  var username: String!
  var picture: UIImage!
  var content: String!
  var retweet: String!
  var favorite: String!
  var date: String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      nameL.text = name
      usernameL.text = username
      picB.image = picture
      contentL.text = content
      dateL.text = date
      favoriteValL.text = favorite
      retweetValL.text = retweet
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func backButton(_ sender: Any) {
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
