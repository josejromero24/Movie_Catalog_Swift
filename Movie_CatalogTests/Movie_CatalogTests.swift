//
//  Movie_CatalogTests.swift
//  Movie_CatalogTests
//
//  Created by José Javier Romero on 21/11/23.
//

import XCTest
@testable import Movie_Catalog

final class Movie_CatalogTests: XCTestCase {

    func testGetMoviesSuccess() {
         let viewModel = MovieViewModel()
         let expectation = self.expectation(description: "getMovies")

         viewModel.getMovies {
             expectation.fulfill()
         }
         waitForExpectations(timeout: 10, handler: nil)

         XCTAssertFalse(viewModel.showLoader, "Show Loader")
        XCTAssertGreaterThan(viewModel.movies.count, 0, "Number of movies > 0")
     }

    func testGetMoviesFailure() {
        let viewModel = MovieViewModel()
        MovieService.shared.simulateFailure = true
        let expectation = self.expectation(description: "getMovies completion called")

        viewModel.getMovies {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(viewModel.numberOfMovies(), 0, "Number of movies should be 0")
        XCTAssertNotNil(viewModel.errorMessage, "Failure")
    }

    
    func testSearchMovieByTitleWithResults() {
        let viewModel = MovieViewModel()
        let movies = [
            Movie(adult: false, backdropPath: "/jlkasldalksd.jpg", genreIDS: [0], id: 123, originalLanguage: "en-EN", originalTitle: "Cenicienta", overview: "", popularity: 8.0, posterPath: "/jlkasldalksd.jpg", releaseDate: "2023-09-1", title: "Cenicienta", video: false, voteAverage: 6.0, voteCount: 200),
            
            Movie(adult: false, backdropPath: "/jlkasldalksd.jpg", genreIDS: [0], id: 123, originalLanguage: "en-EN", originalTitle: "Bambi", overview: "", popularity: 8.0, posterPath: "/jlkasldalksd.jpg", releaseDate: "2023-09-1", title: "Bambi", video: false, voteAverage: 6.0, voteCount: 200),
            
            Movie(adult: false, backdropPath: "/jlkasldalksd.jpg", genreIDS: [0], id: 123, originalLanguage: "en-EN", originalTitle: "Batman", overview: "", popularity: 8.0, posterPath: "/jlkasldalksd.jpg", releaseDate: "2023-09-1", title: "Batman", video: false, voteAverage: 6.0, voteCount: 200)
        
        ]
        
        viewModel.movies = movies

        let searchText = "Batman"
        viewModel.searchMovieByTitle(with: searchText)

        XCTAssertTrue(viewModel.getIsFilterUsed(), "After search")
        XCTAssertEqual(viewModel.numberOfMovies(), 1, "Number of filtered movies == 1")
        XCTAssertEqual(viewModel.movie(at: 0).title, "Batman", "Wrong movie title")
    }
    
    
    
    
    
    
}
