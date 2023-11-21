//
//  MovieCell.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import UIKit


class MovieCell: UITableViewCell {
   
    let urlBaseImage = "https://image.tmdb.org/t/p/w500/"
    
    
    @IBOutlet weak var labelTitleMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuraciones adicionales, si es necesario
    }

    func configureCell(movie: Movie) {
        self.labelTitleMovie.text = movie.title ?? ""
        //self.imgMovie.image
        print("JJASD Movie ---> ", movie)
    }
    
    
}
    
    
    
