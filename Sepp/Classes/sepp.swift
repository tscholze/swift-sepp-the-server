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
    // MARK: - twohundred Init -
    
    override func handleRequest(request: HTTPRequest) -> HTTPResponse
    {
        if request.indexRequested
        {
            let rootPath    = "."
            let content     = directoryContent(rootPath)
            
            if content.contains(SeppSetting.IndexFileName)
            {
                return indexFile(rootPath)
            }
            
            else
            {
                 return dirListing(rootPath)
            }
        }
        
        if request.folderRequested
        {
            return dirListing(request.artefactsString)
        }
        
        let mimeType = request.artefactsString.fileType.mimeType
        
        return HTTPResponse(.Ok, body: [.File(request.artefactsString)], contentType: mimeType)
    }
    
    
    // MARK: - Helper -
    
    /// Returns a HTTPRequests that contains a link index to the file of the path
    ///
    /// - paramter path: Pth aka artefactString
    private func indexFile(var path: String) -> HTTPResponse
    {
        if !path.hasSuffix(SeppSetting.IndexFileName)
        {
            path.appendContentsOf("/\(SeppSetting.IndexFileName)")
        }
        
        return HTTPResponse(.Ok, body: [.File(path)], contentType: path.fileType.mimeType)
    }
    
    /// Gets the content of a given path
    ///
    /// - paramter path: Path aka artefactString
    private func directoryContent(path: String) -> [String]
    {
        let fileManager = NSFileManager.defaultManager()
        
        do
        {
            return try fileManager.contentsOfDirectoryAtPath(path)
        }
        
        catch
        {
            return []
        }
    }
    
    /// Renders a html dir listing of the given path as HTTPResponse
    ///
    /// - parameter path: Path aka artefactString
    private func dirListing(path: String) -> HTTPResponse
    {
        let fileManager             = NSFileManager.defaultManager()
        var isDirectory: ObjCBool   = false
        var listing                 = ""
        let items                   = directoryContent(path)
        
        for item in items
        {
            var pathToItem = "\(path)/\(item)"
            fileManager.fileExistsAtPath(pathToItem, isDirectory:&isDirectory)
            pathToItem = "/\(pathToItem)"
            
            if !isDirectory
            {
                listing += TemplateBuilder.getRenderingForDirectoryListingItem(pathToItem, item: item)
            }
            
            else
            {
                listing += TemplateBuilder.getRenderingForDirectoryListingDirectory(pathToItem, item: item)
            }
        }
        
        let result = TemplateBuilder.getRenderingForDirectoryListing(path, listing: listing)
        return HTTPResponse(.Ok, body: [.StringData(result)], contentType: "text/html")
    }
}
