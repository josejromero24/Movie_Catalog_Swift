//
//  MovieViewModel.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import Foundation

class MovieViewModel {
    private var movies: [Movie] = []
    private var currentPage = 1
    
    func getMovies(completion: @escaping () -> Void) {
        MovieService.shared.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newMovies):
                self.movies.append(contentsOf: newMovies)
                self.currentPage += 1
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
            
            completion()
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
}