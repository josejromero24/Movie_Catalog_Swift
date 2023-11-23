//
//  MovieDetailViewController.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 22/11/23.
//

import Foundation


import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController{
    
    var movieID = 0
    let viewModel = MovieDetailViewModel()
    
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvOverview: UITextView!
    
    @IBOutlet weak var lblRating: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigation()
        self.loadMovieDetail()
        
    }
    
    func configureNavigation(){
        self.title = NSLocalizedString("detailsTitle", comment: "")
        let backButton = UIBarButtonItem()
        backButton.title = NSLocalizedString("movieListTitle", comment: "")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    func loadMovieDetail() {
        
        viewModel.getMovieDetail(movieId: movieID) { [weak self] in
            DispatchQueue.main.async {
                self?.configureView()
            }
        }
    }
    
    
    func configureView(){
        self.imgPoster.setShadowBorder()
        
        if viewModel.getMovieDetail().id != 0 {
            let details = viewModel.getMovieDetail()
            
            guard let posterPath = details.posterPath else {
                print("Error on get posterPath")
                return
            }
            guard let backdropPath = details.backdropPath else {
                print("Error on get backdropPath")
                return
            }
            
            let urlImgPoster = "\(AlamofireUtils.getUrlBaseImage())\(posterPath)"
            let urlImgBackdrop = "\(AlamofireUtils.getUrlBaseImage())\(backdropPath)"
            self.imgBackdrop.kf.setImage(with: URL(string: urlImgBackdrop))
            self.imgPoster.kf.setImage(with: URL(string: urlImgPoster))
            
            self.lblTitle.text = details.title
            self.tvOverview.text = details.overview
            
            if let average = details.voteAverage {
                
                let formatAverage = String(format: "%.2f", average)
                self.lblRating.text = "\(formatAverage) / 10 ⭐"
            }
        }
    }
    
}
