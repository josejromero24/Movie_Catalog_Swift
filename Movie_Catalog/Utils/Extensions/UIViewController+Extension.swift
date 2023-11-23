//
//  UIViewController+Extension.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 22/11/23.
//

import UIKit

extension UIViewController {
    func showAlert( _ message: String, reloadData: @escaping () -> Void ) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let tapOkAction = UIAlertAction(title: "OK", style: .default) { _ in
            reloadData()
        }
        alert.addAction(tapOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isShowLoader<ViewModel>(viewModel: ViewModel, loaderIndicator: UIActivityIndicatorView, showLoader: Bool){
        if showLoader == true {
            loaderIndicator.startAnimating()
            loaderIndicator.isHidden = false
        } else {
            loaderIndicator.stopAnimating()
            loaderIndicator.isHidden = true
        }
      }
}
