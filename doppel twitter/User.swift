//
//  User.swift
//  doppel twitter
//
//  Created by fer on 2/28/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class User: NSObject {

  var name: NSString?
  var userName: NSString?
  var profUrl: NSURL?
  var tag: NSString?
  var followers: Int?
  var following: Int?
  var dictionary: NSDictionary?
  var tweetsNum: Int?
  var bannerImageUrl: NSURL?
  
  static let UserDidLogoutNotification = "UserDidLogout"
  
  init(dictionary: NSDictionary){
    self.dictionary = dictionary
    
    name = dictionary["name"] as? NSString
    userName = dictionary["screen_name"] as? NSString
    tag = dictionary["description"] as? NSString
    followers = (dictionary["followers_count"] as? Int)!
    following = (dictionary["friends_count"] as? Int)!
    tweetsNum = (dictionary["statuses_count"] as? Int)!
    
    let profUrlString = dictionary["profile_image_url_https"] as? String
    if let profUrlString = profUrlString {
      profUrl = NSURL(string: profUrlString)
    }
    
    let bannerUrlString = dictionary["profile_banner_url"] as? String
    if let bannerUrlString = bannerUrlString {
      bannerImageUrl = NSURL(string: bannerUrlString)
    }
  }
  
  static let userDidLogoutNotification = "UserDidLogout"
  
  static var _currentUser: User?
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        let defaults = UserDefaults.standard
        
        let userData = defaults.object(forKey: "currentUserData") as? NSData
        
        if let userData = userData{
          let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [.allowFragments]) as! NSDictionary
          
          _currentUser = User(dictionary: dictionary)
        }
      }
      
      return _currentUser
    }
    set(user) {
      _currentUser = user
      
      let defaults = UserDefaults.standard
      
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(data, forKey: "currentUserData")
      }
      else{
        defaults.removeObject(forKey: "currentUserData")
      }
      defaults.synchronize()
    }
  }
}
