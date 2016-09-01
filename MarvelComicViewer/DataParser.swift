//
//  DataParser.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-30.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class DataParser: NSObject {
    static func parseFetchedComicData(_ data: [AnyHashable : Any]) -> [Comic] {
        var comics = [Comic]()
        let comicsData = (data["data"] as! [AnyHashable : Any])["results"] as! [[AnyHashable : Any]];
        print(comicsData)
        
        for comicAttributes in comicsData {
            let comic = Comic.init(attributes: comicAttributes)
            if let comic = comic {
                comics.append(comic)
            }
        }
        
        return comics
    }
}
