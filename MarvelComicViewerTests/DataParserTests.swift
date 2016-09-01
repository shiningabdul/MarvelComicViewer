//
//  DataParserTests.swift
//  MarvelComicViewer
//
//  Created by Abdul Aljebouri on 2016-09-01.
//  Copyright © 2016 abdulaljebouri. All rights reserved.
//

import XCTest

class DataParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseFetchedData_EmptyData_ReturnsEmptyComicsArray() {
        // Arrange
        let comicsData = [[AnyHashable : Any]]()
        let data : [AnyHashable : Any] = ["data" : ["results" : comicsData]]
        
        // Act
        let parsedComics = DataParser.parseFetchedComicData(data)
        
        // Assert
        XCTAssertNotNil(parsedComics, "DataParser returned a nil object instead of an array of Comic objects")
        XCTAssertEqual(parsedComics.count, 0, "DataParser returned a non-empty array of Comic objects")
    }

    func testParseFetchedData_ParsesComicDataCorrectly() {
        // Arrange
        let comicsData = [["title" : "Comic title", "issueNumber" : 6, "description" : "A great comic.", "isbn" : "9090", "thumbnail" : ["extension" : "jpg", "path" : "www.com"]]]
        let data : [AnyHashable : Any] = ["data" : ["results" : comicsData]]
        
        // Act
        let parsedComics = DataParser.parseFetchedComicData(data)
        
        // Assert
        XCTAssertNotNil(parsedComics, "DataParser returned a nil object instead of an array of Comic objects")
        XCTAssertEqual(parsedComics.count, 1, "DataParser returned an empty array of Comic objects")
        
        let parsedComic = parsedComics[0]
        
        XCTAssertEqual(parsedComic.title, "Comic title", "DataParser parsed the comic title incorrectly")
        XCTAssertEqual(parsedComic.issueNumber, 6, "DataParser parsed the issue number incorrectly")
        XCTAssertEqual(parsedComic.comicDescription, "A great comic.", "DataParser parsed the comic description incorrectly")
        XCTAssertEqual(parsedComic.isbn, "9090", "DataParser parsed the isbn incorrectly")
        XCTAssertEqual(parsedComic.thumbnail?.path, "www.com", "DataParser parsed the comic thumbnail path incorrectly")
        XCTAssertEqual(parsedComic.thumbnail?.thumbnailExtension, "jpg.com", "DataParser parsed the thumnail extension incorrectly")
    }
}
