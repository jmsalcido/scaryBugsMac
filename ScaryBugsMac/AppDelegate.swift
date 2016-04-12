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
        
        masterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let verticalContraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subView": masterViewController.view])
        let horizontalContraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["subView": masterViewController.view])
        NSLayoutConstraint.activateConstraints(verticalContraints + horizontalContraints)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

