//
//  TwitterClient.swift
//  doppel twitter
//
//  Created by fer on 2/28/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "Lz6KUIcW6GlaB8TocOxZ8EqNZ", consumerSecret: "TnF4SW37i7Ib3JBvmxzhU9t3VHrblYRIpODJDEaJC1W54xTZIs")
  
  var loginSuccess: (()->())?
  var loginFailure: ((NSError) -> ())?
  
  func homeTimeline(count:Int, success: @escaping ([Tweet])->(), failure: @escaping (NSError)->()){
    get("1.1/statuses/home_timeline.json?count=\(count)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      
      success(tweets)
      
    }, failure: { (task: URLSessionDataTask?,error: Error) in
      failure(error as NSError)
    })
  }
  
  func currentAccount(success: @escaping (User)->(), failure: @escaping (NSError)->()){
    get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
      
      let userDictionary = response as? NSDictionary
      let user = User(dictionary: userDictionary!)
      
      success(user)
      
      print("name: \(user.name)")
      print("screenname: \(user.userName)")
      print("profile image: \(user.profUrl)")
      print("description: \(user.tag)")
    }, failure: { (task: URLSessionDataTask?, error: Error) in
      failure(error as NSError)
    })
  }
  
  func login(success: @escaping ()->(), failure: @escaping (NSError)->())
  {
    //
    loginSuccess = success
    loginFailure = failure
    
    TwitterClient.sharedInstance?.deauthorize()
    TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "doppel twitter://oauth") as URL!, scope: nil, success: { (requestToken:BDBOAuth1Credential?) in
        print("TEST1")
        let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
      
      UIApplication.shared.openURL(url as URL)
    
    }, failure: { (error: Error?) in
      print("error: \(error?.localizedDescription)")
      self.loginFailure?(error as! NSError)
    })
  }
  
  func logout()
  {
    User.currentUser = nil
    deauthorize()
    
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: "currentUserData")
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.UserDidLogoutNotification), object: nil)
  }
  
  func handleOpenUrl(url: NSURL)
  {
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessToken(withPath: "https://api.twitter.com/oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
      print("TEST2")
      
      self.currentAccount(success: { (user: User) in
        User.currentUser = user
        self.loginSuccess?()
      }, failure: { (error: NSError) in
        self.loginFailure?(error)
      })
      
      
    }, failure: { (error: Error?) in
      print("Error: \(error?.localizedDescription)")
      self.loginFailure?(error as! NSError)
    })
    
  }
}
