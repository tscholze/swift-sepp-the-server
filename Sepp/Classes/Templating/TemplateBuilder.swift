//
//  TemplateBuilder.swift
//  Sepp
//
//  Created by Tobias Scholze on 08/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Foundation
import Mustache

class TemplateBuilder
{
    /// Returns a rendering without custom data for identifier
    ///
    /// - parameter identifier: Template identifier
    class func getRendering(identifier: String) -> String
    {
        let template = try! Template(named: identifier)
        return try! template.render()
    }
    
    /// Returns a rendering with custom data for identifier
    ///
    /// - parameter identifier: Template identifier
    /// - parameter data: String dictionary with data
    class func getRendering(identifier: String, data: [String: String]) -> String
    {
        let template = try! Template(named: identifier)
        return try! template.render(Box(data))
    }
    
    /// Returns a rendering for a directory listing
    ///
    /// - parameter folder: Name of the folder
    /// - parameter data: Listing html content
    class func getRenderingForDirectoryListing(folder: String, listing: String) -> String
    {
        let data = ["folder": folder, "listing": listing]
        return getRendering("dirlisting", data: data)
    }
    
    /// Returns a rendering for a directory item
    ///
    /// - parameter link: Link aka path to the directory
    /// - parameter item: Name / human readable identifier of the item
    class func getRenderingForDirectoryListingItem(link: String, item: String) -> String
    {
        let data = ["link": link, "item": item]
        return getRendering("dirlisting-item", data: data)
    }
    
    /// Returns a rendering for a file item
    ///
    /// - parameter link: Link aka path to the file
    /// - parameter item: Name / human readable identifier of the item
    class func getRenderingForDirectoryListingDirectory(link: String, item: String) -> String
    {
        let data = ["link": link, "item": item]
        return getRendering("dirlisting-directory", data: data)
    }
}