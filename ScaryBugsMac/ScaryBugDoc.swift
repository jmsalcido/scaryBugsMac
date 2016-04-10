//
//  ScaryBugDoc.swift
//  ScaryBugsMac
//
//  Created by Jose Miguel Salcido on 4/9/16.
//  Copyright © 2016 Jose Miguel Salcido. All rights reserved.
//

import Cocoa

class ScaryBugDoc: NSObject {
    var data: ScaryBugData
    var thumbImage: NSImage?
    var fullImage: NSImage?
    
    override init() {
        self.data = ScaryBugData()
    }
    
    init(title: String, rating: Double, thumbImage: NSImage?, fullImage: NSImage?) {
        self.data = ScaryBugData(title: title, rating: rating)
        self.thumbImage = thumbImage
        self.fullImage = fullImage
    }
    
}
