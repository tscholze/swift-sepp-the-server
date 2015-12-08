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
    enum FileType
    {
        case Jpeg
        case Png
        case Gif
        case Html
        case Css
        case JavaScript
        case Stream
        
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
        
        /// Represents the suffix / extenion if a file type
        /// E.g.: a Jpeg image -> .jpg
        var suffix: String
        {
            switch self
            {
            case .Jpeg:
                return "jpg"
                
            case .Png:
                return "png"
                
            case .Gif:
                return "gif"
                
            case .Html:
                return "html"
                
            case .Css:
                return "css"
                
            case .JavaScript:
                return "js"
                
            case .Stream:
                return ""
            }
        }
    }
    
    var hasJpgSuffix: Bool
    {
        return hasSuffix(FileType.Jpeg.suffix)
    }
    
    var hasPngSuffix: Bool
    {
        return hasSuffix(FileType.Png.suffix)
    }
    
    var hasGifSuffix: Bool
    {
        return hasSuffix(FileType.Gif.suffix)
    }
    
    var hasHtmlSuffix: Bool
    {
        return hasSuffix(FileType.Html.suffix)
    }
    
    var hasCssSuffix: Bool
    {
        return hasSuffix(FileType.Css.suffix)
    }
    
    var hasJavaScriptSuffix: Bool
    {
        return hasSuffix(FileType.JavaScript.suffix)
    }
    
    var fileType: FileType
    {
        guard let suffix = componentsSeparatedByString(".").last else
        {
            return FileType.Stream
        }
        
        switch suffix.lowercaseString
        {
        case FileType.Jpeg.suffix:
            return FileType.Jpeg
            
        case FileType.Png.suffix:
            return FileType.Png
            
        case FileType.Gif.suffix:
            return FileType.Gif
            
        case FileType.Html.suffix:
            return FileType.Html
            
        case FileType.JavaScript.suffix:
            return FileType.JavaScript
            
        case FileType.Css.suffix:
            return FileType.Css
            
        default:
            return FileType.Stream
        }
    }
}
