//
//  AppDelegate.swift
//  ScaryBugsMac
//
//  Created by Jose Miguel Salcido on 4/9/16.
//  Copyright © 2016 Jose Miguel Salcido. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var masterViewController: MasterViewController!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        window.contentView?.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView! as NSView).bounds
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

