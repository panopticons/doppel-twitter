//
//  ViewController.swift
//  doppel twitter
//
//  Created by fer on 2/21/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func logIn(_ sender: UIButton) {
    TwitterClient.sharedInstance?.login(success: {
      print("Success")
      self.performSegue(withIdentifier: "login1", sender: nil)
    }, failure: { (error: NSError) in
      print("Error: \(error.localizedDescription)")
    })
  }
}



