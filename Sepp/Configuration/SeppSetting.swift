//
//  SeppSetting.swift
//  Sepp
//
//  Created by Tobias Scholze on 08/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Foundation

struct SeppSetting
{
    /// Server Port
    static let Port: UInt16     = 1337
    
    /// Working Directory, will be scanned for content
    static let WorkingDirectory = "/Users/tobias/Desktop/Sepp-Web"
    
    /// Name of an optional index file that will be rendered instead 
    /// of a dir listing
    static let IndexFileName    = "index.html"
}