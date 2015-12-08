//
//  sepp.swift
//  Sepp
//
//  Created by Tobias Scholze on 07/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Foundation
import twohundred
import Mustache

class Sepp: TwoHundredServer
{
    override func handleRequest(request: HTTPRequest) -> HTTPResponse
    {
        if request.indexRequested
        {
            return dirListing(".")
        }
        
        if request.folderRequested
        {
            return dirListing(request.artefactsString)
        }
        
        let file            = request.artefactsString
        let contentType     = file.fileType
        
        return HTTPResponse(.Ok, body: [.File(file)], contentType: contentType.mimeType)
    }
    
    
    // MARK: - Helper -
    
    private func dirListing(path: String) -> HTTPResponse
    {
        let fileManager             = NSFileManager.defaultManager()
        var isDirectory: ObjCBool   = false
        var listing                 = ""
        
        do
        {
            let items = try fileManager.contentsOfDirectoryAtPath(path)
            
            for item in items
            {
                let pathToItem = "\(path)/\(item)"
                fileManager.fileExistsAtPath(pathToItem, isDirectory:&isDirectory)
                
                if !isDirectory
                {
                    listing += TemplateBuilder.getRenderingForDirectoryListingItem(pathToItem, item: item)
                }
                
                else
                {
                    listing += TemplateBuilder.getRenderingForDirectoryListingDirectory(pathToItem, item: item)
                }
            }
        }
        
        catch
        {
            fatalError("Error while proccesing path: \(path)")
        }
        
        let result = TemplateBuilder.getRenderingForDirectoryListing(path, listing: listing)
        return HTTPResponse(.Ok, body: [.StringData(result)], contentType: "text/html")
    }
}
