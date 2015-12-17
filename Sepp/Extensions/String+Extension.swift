//
//  String+Extension.swift
//  Sepp
//
//  Created by Tobias Scholze on 07/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Foundation

extension String
{
    enum FileType: String
    {
        case Jpeg       = "jpg"
        case Png        = "png"
        case Gif        = "gif"
        case Html       = "html"
        case Css        = "css"
        case JavaScript = "js"
        case Stream     = ""
        
        /// Represents the ISO string value of the file's mime type.
        /// E.g.: "image/jpeg"
        var mimeType: String
        {
            switch self
            {
            case .Jpeg:
                return "image/jpeg"
                
            case .Png:
                return "image/png"
                
            case .Gif:
                return "image/gif"
                
            case .Html:
                return "text/html"
                
            case .Css:
                return "text/css"
                
            case .JavaScript:
                return "text/javascript"
                
            case .Stream:
                return "application/octet-stream"
            }
        }
    }
    
    var hasJpgSuffix: Bool
    {
        return hasSuffix(FileType.Jpeg.rawValue)
    }
    
    var hasPngSuffix: Bool
    {
        return hasSuffix(FileType.Png.rawValue)
    }
    
    var hasGifSuffix: Bool
    {
        return hasSuffix(FileType.Gif.rawValue)
    }
    
    var hasHtmlSuffix: Bool
    {
        return hasSuffix(FileType.Html.rawValue)
    }
    
    var hasCssSuffix: Bool
    {
        return hasSuffix(FileType.Css.rawValue)
    }
    
    var hasJavaScriptSuffix: Bool
    {
        return hasSuffix(FileType.JavaScript.rawValue)
    }
    
    var fileType: FileType
    {
        guard let suffix = componentsSeparatedByString(".").last else
        {
            return FileType.Stream
        }
        
        guard let _fileType = FileType(rawValue: suffix) else
        {
            return FileType.Stream
        }
        
        return _fileType
    }
}
