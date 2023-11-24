//
//  MovieService.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import Alamofire

enum CustomErrorForTest: Error {
    case customError
}


class MovieService {
    static let shared = MovieService()
    
    var simulateFailure: Bool = false
    private init() {}
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let headers = AlamofireUtils.createHeaders()
        let urlString = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=\(page)"
        
        
        if simulateFailure {
            completion(.failure(CustomErrorForTest.customError))
        } else {
            AF.request(urlString,method: .get, headers: headers).responseDecodable(of: MoviesParent.self) { response in
                switch response.result {
                case .success(let listOfMovies):
                    // If the movie array is empty or null we return it without data.
                    completion(.success(listOfMovies.movies ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
    
    
    
    func getMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        
        let headers = AlamofireUtils.createHeaders()
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?language=en-US"
        
        
        if simulateFailure {
            completion(.failure(CustomErrorForTest.customError))
        } else {
            AF.request(urlString,method: .get, headers: headers).responseDecodable(of: MovieDetail.self) { response in
                switch response.result {
                case .success(let movieDetails):
                    completion(.success(movieDetails))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    }
    
}
