//
//  MovieCell.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import UIKit
import Kingfisher


class MovieCell: UITableViewCell {
    
// We make an override of setSelected to set the color to white so that it does not remain "pressed".
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           if selected {
               contentView.backgroundColor = UIColor.white
           }
       }
    
    @IBOutlet weak var labelTitleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var tfDescriptionMovie: UITextView!
    @IBOutlet weak var lblScrollForMore: UILabel!
    @IBOutlet weak var tapView: UIView!
    @IBOutlet weak var labelTapTitle: UILabel!
    @IBOutlet weak var progressBar: RoundProgressBar!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tfDescriptionMovie.delegate = self
        self.labelTapTitle.text = NSLocalizedString("tapToSeeDetails", comment: "")
        
        self.lblScrollForMore.text = NSLocalizedString("scrollReadMore", comment: "")
    }
    
    func configureCell(movie: Movie) {
        self.labelTitleMovie.text = movie.title ?? ""
        let urlImage = self.createUrlImage(urlFromImage: movie.posterPath ?? "")
        self.imageMovie.kf.setImage(with: urlImage)
        self.tfDescriptionMovie.text = movie.overview ?? ""
        self.lblScrollForMore.layer.cornerRadius = 10
        self.lblScrollForMore.layer.masksToBounds = true
        self.progressBar.setProgress(Float(movie.voteAverage ?? 0.0))
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
            url = "\(AlamofireUtils.getUrlBaseImage())\(urlFromImage)"
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
                self.hidePlaceholder()
            }
        }
}

