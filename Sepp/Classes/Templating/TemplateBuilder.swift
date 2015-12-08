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
    class func getRendering(identifier: String) -> String
    {
        let template = try! Template(named: identifier)
        return try! template.render()
    }
    
    class func getRendering(identifier: String, data: [String: String]) -> String
    {
        let template = try! Template(named: identifier)
        return try! template.render(Box(data))
    }
    
    class func getRenderingForDirectoryListing(folder: String, listing: String) -> String
    {
        let data = ["folder": folder, "listing": listing]
        return getRendering("dirlisting", data: data)
    }
    
    class func getRenderingForDirectoryListingItem(link: String, item: String) -> String
    {
        let data = ["link": link, "item": item]
        return getRendering("dirlisting-item", data: data)
    }
    
    class func getRenderingForDirectoryListingDirectory(link: String, item: String) -> String
    {
        let data = ["link": link, "item": item]
        return getRendering("dirlisting-directory", data: data)
    }
}