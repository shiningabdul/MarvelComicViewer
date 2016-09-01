//
//  Comic.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-30.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class Comic: NSObject {
    var thumbnail:Thumbnail?
    var title:String?
    var issueNumber:Int?
    var comicDescription: String?
    var isbn:String?
    
    static let imageFormat = "portrait_xlarge"
    
    init?(attributes: [AnyHashable : Any])
    {
        guard let title = attributes["title"] as? String,
        let issueNumber = attributes["issueNumber"] as? Int,
        let description = attributes["description"] as? String,
        let isbn = attributes["isbn"] as? String,
        let thumbnail = attributes["thumbnail"] as? [String: String],
        let thumbnailExtension = thumbnail["extension"],
        let path = thumbnail["path"]
        else {
            return nil
        }
        self.thumbnail = Thumbnail(thumbnailExtension: thumbnailExtension, path: path)
        self.title = title
        self.issueNumber = issueNumber
        self.comicDescription = description
        self.isbn = isbn
    }
}

struct Thumbnail {
    var thumbnailExtension:String
    var path:String
}
