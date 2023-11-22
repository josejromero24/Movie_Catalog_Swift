//
//  MovieDetailViewController.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 22/11/23.
//

import Foundation


import UIKit

class MovieDetailViewController: UIViewController{
    
    @IBOutlet weak var testTitle: UILabel!
    var movieID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("JJASD MovieID ---> ", movieID)
        self.testTitle.text = movieID
        
    }
    
}
