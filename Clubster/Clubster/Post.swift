//
//  Post.swift
//  Clubster
//
//  Created by Jack Frederick Hurley on 11/30/17.
//  Copyright © 2017 Adam Barson. All rights reserved.
//

import Foundation


public class Post {
    public var post_id: String?
    public var clubname: String?
    public var timestamp: Date?
    public var body: String?
    init(post_id: String, clubname: String, seconds: String, body: String) {
        self.post_id = post_id
        self.clubname = clubname
        let formatter = DateFormatter()
        self.timestamp = formatter.date(from: seconds) // format will be "MMM d, h:mm a"
        self.body = body
    }
}

//var date = Date(timeIntervalSince1970: TimeInterval(0))
//let formatter = DateFormatter()
//
//formatter.dateFormat = "MMM d, h:mm a"
//
//var str = formatter.string(from: date)
//
//print(str)
