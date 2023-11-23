//
//  UIImageView+Extension.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 23/11/23.
//


import UIKit

extension UIImageView {
    
    
    //Show a shadow around the border of the view.
     
    func setShadowBorder(color: CGColor = UIColor.black.cgColor, shadowRadious: CGFloat = 5) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadious
        self.layer.shadowOpacity = 0.5
    }
}
