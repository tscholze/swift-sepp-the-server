//
//  HTTPRequest+Extensions.swift
//  Sepp
//
//  Created by Tobias Scholze on 07/12/15.
//  Copyright © 2015 Tobias Scholze. All rights reserved.
//

import Foundation
import twohundred


extension HTTPRequest
{
    /// True if the request is routed to the root index
    /// http://foo.tld -> true -- http://foo.tld/mow -> false
    var indexRequested: Bool
    {
        return artefactsString.characters.count == 0
    }
    
    /// True if a folder is the target of the request
    /// http://foo.tld/mow -> true -- http://foo.tld/test.html -> false
    var folderRequested: Bool
    {
        var s = stat()
        if stat(artefactsString, &s) == 0
        {
            if s.st_mode & S_IFDIR != 0
            {
                return true
            }
        }
        
        return false
    }
    
    /// Gets the artefact string of a request.
    /// http://foo.tld/test/anotherTest -> test/anotherTest
    var artefactsString: String
    {
        return self.header.url.substringFromIndex(self.header.url.characters.startIndex.advancedBy(1)).urlDecodedString()
    }
}
