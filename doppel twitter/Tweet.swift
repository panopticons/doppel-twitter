//
//  Tweet.swift
//  doppel twitter
//
//  Created by fer on 2/28/17.
//  Copyright © 2017 fer. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var name: NSString?
  var text: NSString?
  var time: NSDate?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var user: User?
  
  init(dictionary: NSDictionary)
  {
    text = dictionary["text"] as? NSString
    
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
    
    let timeString = dictionary["created_at"] as? String
    
    if let timeString = timeString {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      
      time = formatter.date(from: timeString) as NSDate?
    }
  }
  
  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]
  {
    var tweets = [Tweet]()
    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      
      tweets.append(tweet)
    }
    return tweets
  }
}
