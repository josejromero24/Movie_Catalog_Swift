//
//  MovieDetailViewModel.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 22/11/23.
//

import Foundation
import UIKit


class MovieDetailViewModel {
    var showLoader: Bool = true
    var showError: (() -> Void)?
    var errorMessage: String = ""
    
    private var movieDetail: MovieDetail = MovieDetail(adult: false, backdropPath: "", belongsToCollection: BelongsToCollection(id: 0, name: "", posterPath: "", backdropPath: ""), budget: 0, genres: [Genre(id: 0, name: "")], homepage: "", id: 0, imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", productionCompanies: [ProductionCompany(id: 0, logoPath: "", name: "", originCountry: "")], productionCountries: [ProductionCountry(iso3166_1: "", name: "")], releaseDate: "", revenue: 0, runtime: 0, spokenLanguages: [SpokenLanguage(englishName: "", iso639_1: "", name: "")], status: "", tagline: "", title: "", video: false, voteAverage: 0.0, voteCount: 0)
    
    func getMovieDetail(movieId: Int, completion: @escaping () -> Void) {
        self.showLoader = true
        MovieService.shared.getMovieDetail(movieId: movieId){ [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movieDetail):
                print("OK")
                self.movieDetail = movieDetail
            case .failure(let error):
                print("KO")
                 print("Error get movie detail:  \(error.localizedDescription)")
                 self.errorMessage = error.localizedDescription
                 self.showError?()
            }
                self.showLoader = false
                completion()
        }
    }
    
    
    func getMovieDetail() -> MovieDetail {
        return self.movieDetail
    }
    
}
