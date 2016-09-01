//
//  ViewController.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-08-30.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var marvelConnector: MarvelConnector!
    var comics: [Comic]!
    
    @IBOutlet weak var comicsCollection: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(comicDataLoaded), name: MarvelConnector.ComicDataFetchCompletedNotification, object: nil)
        
        self.comics = [Comic]()
        
        self.marvelConnector = MarvelConnector()
        self.marvelConnector.fetchComicData()
        
        self.comicsCollection.delegate = self
        self.comicsCollection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return comics.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ComicCollectionCell
        let comic = comics[indexPath.row]
        cell.comic = comic
        cell.loadImage()
        
        return cell
    }

    func comicDataLoaded(_ notification: Notification){
        self.comics = DataParser.parseFetchedComicData(notification.userInfo!)
        
        DispatchQueue.main.async {
            self.comicsCollection.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    

}

