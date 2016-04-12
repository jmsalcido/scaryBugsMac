//
//  MasterViewController.swift
//  ScaryBugsMac
//
//  Created by Jose Miguel Salcido on 4/9/16.
//  Copyright © 2016 Jose Miguel Salcido. All rights reserved.
//

import Cocoa
import Quartz

class MasterViewController: NSViewController {
    
    @IBOutlet weak var bugsTableView: NSTableView!
    @IBOutlet weak var bugTitleView: NSTextFieldCell!
    @IBOutlet weak var bugImageView: NSImageView!
    @IBOutlet weak var bugRatingView: EDStarRating!
    
    let useStub = true
    var bugs = [ScaryBugDoc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bugs = getSampleBugs()
    }
    
    func getSampleBugs() -> [ScaryBugDoc] {
        let sampleBug1 = ScaryBugDoc(title: "Potato Bug", rating: 4.0, thumbImage: NSImage(named: "potatoBugThumb"), fullImage: NSImage(named: "potatoBug"))
        let sampleBug2 = ScaryBugDoc(title: "House Centipede", rating: 3.0, thumbImage: NSImage(named: "centipedeThumb"), fullImage: NSImage(named: "centipede"))
        let sampleBug3 = ScaryBugDoc(title: "Wolf Spider", rating: 5.0, thumbImage: NSImage(named: "wolfSpiderThumb"), fullImage: NSImage(named: "wolfSpider"))
        let sampleBug4 = ScaryBugDoc(title: "Lady Bug", rating: 1.5, thumbImage: NSImage(named: "ladybugThumb"), fullImage: NSImage(named: "ladybug"))
        return [sampleBug1, sampleBug2, sampleBug3, sampleBug4]
    }
    
    func selectedBugDoc() -> ScaryBugDoc? {
        let selectedRow = self.bugsTableView.selectedRow
        if selectedRow >= 0 && selectedRow < self.bugs.count {
            return self.bugs[selectedRow]
        }
        return nil
    }
    
    func reloadSelectedRow() {
        let indexSet = NSIndexSet(index: self.bugsTableView.selectedRow)
        let columSet = NSIndexSet(index: 0)
        self.bugsTableView.reloadDataForRowIndexes(indexSet, columnIndexes: columSet)
    }
    
    func updateDetailInfo(doc: ScaryBugDoc?) {
        var title = ""
        var image = NSImage?()
        var rating = 0.0
        
        if let scaryBugDoc = doc {
            title = scaryBugDoc.data.title
            image = scaryBugDoc.fullImage
            rating = scaryBugDoc.data.rating
        }
        
        self.bugTitleView.stringValue = title
        self.bugImageView.image = image
        self.bugRatingView.rating = Float(rating)
    }
    
    override func loadView() {
        super.loadView()
        
        self.bugRatingView.starHighlightedImage = NSImage(named: "shockedface2_full.png")!
        self.bugRatingView.starImage = NSImage(named: "shockedface2_empty.png")!
        
        self.bugRatingView.delegate = self
        
        self.bugRatingView.maxRating = 5
        self.bugRatingView.horizontalMargin = 12
        self.bugRatingView.editable = true
        self.bugRatingView.displayMode = UInt(EDStarRatingDisplayFull)
        self.bugRatingView.halfStarThreshold = 0.001
        
        self.bugRatingView.rating = Float(0.0)
    }
    
    func pictureTakerDidEnd(picker: IKPictureTaker, returnCode: NSInteger, contextInfo: UnsafePointer<Void>) {
        let image = picker.outputImage()
        
        if image != nil && returnCode == NSModalResponseOK {
            self.bugImageView.image = image
            if let selectedDoc = selectedBugDoc() {
                selectedDoc.fullImage = image
                selectedDoc.thumbImage = image.imageByScalingAndCroppingForSize(CGSize(width: 44, height: 44))
                reloadSelectedRow()
            }
        }
    }
}

// MARK: - IBActions
extension MasterViewController {
    
    @IBAction func changePicture(sender: AnyObject) {
        if selectedBugDoc() != nil {
            IKPictureTaker().beginPictureTakerSheetForWindow(self.view.window, withDelegate: self, didEndSelector: #selector(MasterViewController.pictureTakerDidEnd(_:returnCode:contextInfo:)), contextInfo: nil)
        }
    }
    
    @IBAction func bugTitleDidEndEdit(sender: AnyObject) {
        if let selectedDoc = selectedBugDoc() {
            selectedDoc.data.title = self.bugTitleView.stringValue
            reloadSelectedRow()
        }
    }
    
    @IBAction func addBug(sender: AnyObject) {
        let newDoc = ScaryBugDoc(title: "New Bug", rating: 0.0, thumbImage: nil, fullImage: nil)
        self.bugs.append(newDoc)
        let newRowIndex = self.bugs.count - 1
        
        let nsIndexSet = NSIndexSet(index: newRowIndex)
        
        self.bugsTableView.insertRowsAtIndexes(nsIndexSet, withAnimation: NSTableViewAnimationOptions.EffectGap)
        self.bugsTableView.selectRowIndexes(nsIndexSet, byExtendingSelection: false)
        self.bugsTableView.scrollRowToVisible(newRowIndex)
    }
    
    @IBAction func deleteBug(sender: AnyObject) {
        if selectedBugDoc() != nil {
            self.bugs.removeAtIndex(self.bugsTableView.selectedRow)
            self.bugsTableView.removeRowsAtIndexes(NSIndexSet(index:self.bugsTableView.selectedRow), withAnimation: NSTableViewAnimationOptions.SlideLeft)
            updateDetailInfo(nil)
        }
    }
    
    @IBAction func resetData(sender: AnyObject) {
        bugs = getSampleBugs()
        updateDetailInfo(nil)
        bugsTableView.reloadData()
    }
}

// MARK: - NSTableViewDataSource
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


// MARK: - NSTableViewDelegate
extension MasterViewController: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedDoc = selectedBugDoc()
        updateDetailInfo(selectedDoc)
    }
}

// MARK: - EDStarRatingProtocol
extension MasterViewController: EDStarRatingProtocol {
    func starsSelectionChanged(control: EDStarRating!, rating: Float) {
        if let selectedDoc = selectedBugDoc() {
            selectedDoc.data.rating = Double(self.bugRatingView.rating)
        }
    }
}
