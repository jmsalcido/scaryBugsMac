//
//  MasterViewController.swift
//  ScaryBugsMac
//
//  Created by Jose Miguel Salcido on 4/9/16.
//  Copyright © 2016 Jose Miguel Salcido. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    
    let useStub = true
    var bugs = [ScaryBugDoc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bugs = getBugs()
    }
    
    func getBugs() -> [ScaryBugDoc] {
        if useStub {
            return setupSampleBugs();
        }
        return [ScaryBugDoc]()
    }
    
    func setupSampleBugs() -> [ScaryBugDoc] {
        let stubBug1 = ScaryBugDoc(title: "Potato Bug", rating: 4.0, thumbImage: NSImage(named: "potatoBugThumb"), fullImage: NSImage(named: "potatoBug"))
        let stubBug2 = ScaryBugDoc(title: "House Centipede", rating: 3.0, thumbImage: NSImage(named: "centipedeThumb"), fullImage: NSImage(named: "centipede"))
        let stubBug3 = ScaryBugDoc(title: "Wolf Spider", rating: 5.0, thumbImage: NSImage(named: "wolfSpiderThumb"), fullImage: NSImage(named: "wolfSpider"))
        let stubBug4 = ScaryBugDoc(title: "Lady Bug", rating: 1.0, thumbImage: NSImage(named: "ladyBugThumb"), fullImage: NSImage(named: "ladyBug"))
        return [stubBug1, stubBug2, stubBug3, stubBug4]
    }
    
}
