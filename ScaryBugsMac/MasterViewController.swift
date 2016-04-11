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
        let stubBug4 = ScaryBugDoc(title: "Lady Bug", rating: 1.0, thumbImage: NSImage(named: "ladybugThumb"), fullImage: NSImage(named: "ladybug"))
        return [stubBug1, stubBug2, stubBug3, stubBug4]
    }
    
}

extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.bugs.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        if tableColumn!.identifier == "BugColumn" {
            let bugDoc = self.bugs[row]
            cellView.imageView!.image = bugDoc.thumbImage
            cellView.textField!.stringValue = bugDoc.data.title
            return cellView
        }
        return cellView
    }
    
}

extension MasterViewController: NSTableViewDelegate {
}
