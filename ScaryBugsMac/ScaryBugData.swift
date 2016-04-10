//
//  ScaryBugData.swift
//  ScaryBugsMac
//
//  Created by Jose Miguel Salcido on 4/9/16.
//  Copyright © 2016 Jose Miguel Salcido. All rights reserved.
//

import Cocoa

class ScaryBugData: NSObject {
    var title: String
    var rating: Double
    
    override init() {
        self.title = String()
        self.rating = 0.0
    }
    
    init(title: String, rating: Double) {
        self.title = title
        self.rating = rating
    }
}
