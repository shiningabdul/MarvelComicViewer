//
//  ComicCollectionViewCell.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-31.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class ComicCollectionCell: UICollectionViewCell {
    var comic:Comic!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    func loadImage() {
        let url = URL(string: "\(comic.thumbnail!.path)/\(Comic.imageFormat).\(comic.thumbnail!.thumbnailExtension)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil
            {
                print("Error fetching comic image =\(error)")
                return
            }
            
            if let imageData = UIImage(data: data!) {
                DispatchQueue.main.async {
                    self.moreInfoButton.setImage(imageData, for: UIControlState.normal)
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func moreInfoButtonPressed(_ sender: AnyObject) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let moreInfoViewController = mainStoryboard.instantiateViewController(withIdentifier: "moreInfoView") as! MoreInfoViewController
        moreInfoViewController.comic = comic
        UIApplication.shared.delegate?.window??.rootViewController?.present(moreInfoViewController, animated: true, completion:nil)
    }
}
