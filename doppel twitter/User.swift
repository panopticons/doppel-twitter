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
  
  var dictionary: NSDictionary?
  
  static let UserDidLogoutNotification = "UserDidLogout"
  
  init(dictionary: NSDictionary){
    self.dictionary = dictionary
    
    name = dictionary["name"] as? NSString
    userName = dictionary["screen_name"] as? NSString
    tag = dictionary["description"] as? NSString
    //date = dictiona
    
    let profUrlString = dictionary["profile_image_url_https"] as? String
    if let profUrlString = profUrlString {
      profUrl = NSURL(string: profUrlString)
    }
  }
  
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
