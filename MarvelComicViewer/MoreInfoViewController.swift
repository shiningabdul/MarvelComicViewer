//
//  MoreInfoViewController.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-31.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var issueNumber: UILabel!
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var comicDescription: UILabel!
    
    var comic:Comic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        comicTitle.text = comic.title
        issueNumber.text = "Issue number: \(comic.issueNumber!)"
        isbn.text = comic.isbn
        comicDescription.text = comic.comicDescription
        
        loadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
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
                    self.image.image = imageData
                }
            }
        }
        
        task.resume()
    }

}
