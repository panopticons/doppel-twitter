//
//  ComposeViewController.swift
//  doppel twitter
//
//  Created by fer on 3/10/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

  @IBOutlet weak var uPic: UIImageView!
  @IBOutlet weak var userN: UILabel!
  @IBOutlet weak var realN: UILabel!
  @IBOutlet weak var compBox: UITextView!
  var tweet: Tweet?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        compBox.becomeFirstResponder()
      if tweet == nil {
        print("error")
      }
      
      compBox.delegate = self
    
      TwitterClient.sharedInstance?.currentAccount(success: { (user: User) in
        self.uPic.setImageWith(user.profUrl as! URL)
        self.userN.text = "@\(user.userName!)"
        self.realN.text = user.name! as String
      }, failure: { (error: NSError) in
        print("error")
      })
      
      
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func cancelButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  @IBAction func tweet(_ sender: Any) {
    if(compBox.text.isEmpty)
    {
      let alertController = UIAlertController(title: "Error", message: "Make sure Tweet has content", preferredStyle: .alert)
      
      // create an OK action
      let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        // handle response here.
      }
      // add the OK action to the alert controller
      alertController.addAction(OKAction)
      
      present(alertController, animated: true) {
        // optional code for what happens after the alert controller has finished presenting
      }
    }
    else{
      if tweet == nil {
        TwitterClient.sharedInstance?.tweet(status: compBox.text!, success: {
          print("success")
          self.dismiss(animated: true, completion: nil)
        }, failure: { (error: NSError) in
          let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
          
          // create an OK action
          let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
          }
          // add the OK action to the alert controller
          alertController.addAction(OKAction)
          
          self.present(alertController, animated: true) {
          }
        })
      }
      else{
        TwitterClient.sharedInstance?.reply(text: compBox.text!, id: Int(tweet!.id! as String)! , success: {
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error: NSError) in
          let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)

          let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
          }
          
          alertController.addAction(OKAction)
          
          self.present(alertController, animated: true) {
          }
        })
        
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
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
