//
//  AppDelegate.swift
//  Sepp
//
//  Created by Tobias Scholze on 07/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Cocoa
import twohundred

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    @IBOutlet weak var window                   : NSWindow!
    @IBOutlet weak var openLinkButton           : NSButton!
    @IBOutlet weak var openWorkingDirectoryButton: NSButton!
    @IBOutlet weak var startServerButton        : NSButton!
    @IBOutlet weak var stopServerButton         : NSButton!
    
    let server = Sepp(listenPort: SeppSetting.Port)
    
    // MARK: - Init

    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        chdir(SeppSetting.WorkingDirectory)
        
        if !workingDirectoryChangeWasSuccessful()
        {
            fatalError("Error: Could not change working directory")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
        // stop server
    }
    
    // MARK: - Event handler -
    
    @IBAction func onStartServerClicked(sender: AnyObject)
    {
        print("Starting server ...")
        server.start()
        stopServerButton.enabled    = true
        startServerButton.enabled   = false
        openLinkButton.enabled      = true
        openWorkingDirectoryButton.enabled  = true
    }
    
    @IBAction func onStopServerClicked(sender: AnyObject)
    {
        print("Stopping server ...")
        stopServerButton.enabled    = false
        startServerButton.enabled   = true
        openLinkButton.enabled      = false
        openWorkingDirectoryButton.enabled  = false
    }
    
    @IBAction func onOpenLinkClicked(sender: AnyObject)
    {
        guard let url = NSURL(string: "http://localhost:\(SeppSetting.Port)") else
        {
            return
        }
        
        NSWorkspace.sharedWorkspace().openURL(url)
    }
    
    @IBAction func onOpenDirectoryClicked(sender: AnyObject)
    {
        guard let url = NSURL(string: "file://\(SeppSetting.WorkingDirectory)") else
        {
            return
        }
        
        NSWorkspace.sharedWorkspace().openURL(url)
    }
    
    // MARK: - Helper -
    
    
    /// Returns true if the changed working directory ends to the application name
    private func workingDirectoryChangeWasSuccessful() -> Bool
    {
        var cwd = [CChar](count: Int(FILENAME_MAX), repeatedValue: 0)
        getcwd(&cwd, Int(FILENAME_MAX))
        let dirString = String(CString: cwd, encoding: NSUTF8StringEncoding)!
        
        return dirString == SeppSetting.WorkingDirectory
    }
}

