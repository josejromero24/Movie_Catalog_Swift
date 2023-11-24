//
//  MovieViewModel.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import Foundation
import UIKit

class MovieViewModel {
    
    var showError: (() -> Void)?
    var errorMessage: String = ""
    var showLoader: Bool = true
    var movies: [Movie] = []
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
        var result = 0
        if filteredMovies.isEmpty {
            result = 0
        } else {
            result = filteredMovies.count
        }
        return result
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
    
    
    func didSelectRow(at indexPath: IndexPath, navigationController: UINavigationController?) {
        let selectedCellViewModel = filteredMovies[indexPath.row]
        
        let detalleViewController = UIStoryboard(name: "MovieDetailViewController", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        detalleViewController.movieID = selectedCellViewModel.id ?? 0
        navigationController?.pushViewController(detalleViewController, animated: true)
    }
    
}
