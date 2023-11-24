//
//  MovieDetail_Test.swift
//  Movie_CatalogTests
//
//  Created by José Javier Romero on 24/11/23.
//

import XCTest
@testable import Movie_Catalog

final class MovieDetail_Test: XCTestCase {
    
    
        func testGetMovieDetailSuccess() {
            let viewModel = MovieDetailViewModel()
            let expectation = self.expectation(description: "getMovieDetails")

            viewModel.getMovieDetail(movieId: 1) {
                expectation.fulfill()
            }
            waitForExpectations(timeout: 10, handler: nil)

            XCTAssertFalse(viewModel.showLoader, "Show Loader")
            XCTAssertNotNil(viewModel.movieDetail)
            
        }
    
    
    
    func testGetMovieDetailFailure() {
        let viewModel = MovieDetailViewModel()
        MovieService.shared.simulateFailure = true
        let expectation = self.expectation(description: "getMovies completion called")

        viewModel.getMovieDetail(movieId: 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
        if let id = viewModel.getMovieDetail().id {
            XCTAssertEqual(id, 0, "The id of the movie should be 0")
        }
       
        XCTAssertNotNil(viewModel.errorMessage, "Failure")
    }
    
    
    
}
