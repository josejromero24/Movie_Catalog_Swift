//
//  MovieCell.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import UIKit
import Kingfisher


class MovieCell: UITableViewCell {
    
    let urlBaseImage = "https://image.tmdb.org/t/p/w500/"
    
    @IBOutlet weak var labelTitleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var tfDescriptionMovie: UITextView!
    @IBOutlet weak var lblScrollForMore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tfDescriptionMovie.delegate = self
    }
    
    func configureCell(movie: Movie) {
        self.labelTitleMovie.text = movie.title ?? ""
        let urlImage = self.createUrlImage(urlFromImage: movie.posterPath ?? "")
        self.imageMovie.kf.setImage(with: urlImage)
        self.tfDescriptionMovie.text = movie.overview ?? ""
        self.lblScrollForMore.layer.cornerRadius = 10
        self.lblScrollForMore.layer.masksToBounds = true
    }
    
    
    // Check the size of the text with respect to the size of our UITextView to display the label """placeholder""""
    func isShowPlaceholder() {
        if self.tfDescriptionMovie.contentSize.height > self.tfDescriptionMovie.bounds.size.height {
            self.showPlaceholder()
        } else {
            self.hidePlaceholder()
        }
    }
    
    private func createUrlImage(urlFromImage: String) -> URL {
        // Set the google url as default image url
        var url = "https://www.google.es"
        if !urlFromImage.isEmpty {
            url = "\(urlBaseImage)\(urlFromImage)"
        }
        return URL(string: url)!
    }
    
    func showPlaceholder(){
        self.lblScrollForMore.isHidden = false
    }
    
    func hidePlaceholder(){
        self.lblScrollForMore.isHidden = true
    }
    
    
}



extension MovieCell: UITextViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == tfDescriptionMovie {
                print("El UITextView está haciendo scroll.")
                
                self.hidePlaceholder()
            }
        }
    
}

