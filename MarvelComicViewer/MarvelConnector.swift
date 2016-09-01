//
//  MarvelConnector.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-30.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class MarvelConnector: NSObject {
    private let apiEndpoint = "https://gateway.marvel.com/"
    private let comicEndpoint = "v1/public/comics"
    private let apiKey = "ec4fb6b504a79ff1ad1be8ef18c5e47b"
    private let privateKey = "94aca267edef1fefb1311a0bc011f8ff1def4698"
    
    static let ComicDataFetchCompletedNotification = Notification.Name("kComicDataFetchCompletedNotification")
    
    func fetchComicData() {
        let timeStamp = "\(Date.init().timeIntervalSince1970)"
        let hash = convertToMd5(timeStamp + privateKey + apiKey)
        
        let url = URL(string: apiEndpoint + comicEndpoint + "?ts=\(timeStamp)&apikey=\(apiKey)&hash=\(hash)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print("Error fetching comic data =\(error)")
                return
            }

            do {
                if let serializedJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [AnyHashable : Any] {
                    let notification = Notification(name: MarvelConnector.ComicDataFetchCompletedNotification, object:nil, userInfo:serializedJson)
                    
                    NotificationCenter.default.post(notification)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    // From this answer in stack overflow: http://stackoverflow.com/a/32166735/1461913
    // Updated for Swift 3
    func convertToMd5(_ string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            data.withUnsafeBytes { (bytes: UnsafePointer<CChar>) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        print("hash = \(digestHex)")
        
        return digestHex
    }
}
