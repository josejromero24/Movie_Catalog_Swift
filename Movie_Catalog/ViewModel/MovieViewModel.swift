//
//  MovieViewModel.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import Foundation


class MovieViewModel {
    
    var showError: (() -> Void)?
    var errorMessage: String = ""
    
    var showLoader: Bool = true

    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var currentPage = 1
    private var isFilterUsed = false
    
    
    
    func getMovies(completion: @escaping () -> Void) {
        self.showLoader = true
        MovieService.shared.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newMovies):
                self.movies.append(contentsOf: newMovies)
                self.filteredMovies = self.movies
                self.currentPage += 1
            case .failure(let error):
                print("Error getMovies: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                self.showError?()
            }
                self.showLoader = false
                completion()
        }
    }
    
    func numberOfMovies() -> Int {
        return filteredMovies.count
    }
    
    func movie(at index: Int) -> Movie {
        return filteredMovies[index]
    }
    
    
    func searchMovieByTitle(with searchText: String) {
                if searchText.isEmpty {
                    self.isFilterUsed = false
                    filteredMovies = movies
                } else {
                    self.isFilterUsed = true
                    filteredMovies = movies.filter { $0.title!.lowercased().contains(searchText.lowercased()) }
                }
       }
    
    func getIsFilterUsed() -> Bool {
        return self.isFilterUsed
    }
}
