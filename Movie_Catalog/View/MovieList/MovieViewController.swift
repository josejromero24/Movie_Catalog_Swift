//
//  MovieViewController.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    let nameCell = "MovieCell"
    let viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.showError = {
            DispatchQueue.main.async {
                self.showAlert(self.viewModel.errorMessage, reloadData: {
                    self.tableView.reloadData()
                })
            }
        }
        self.configureView()
        self.configureTableView()
    }
    
    func configureView(){
        self.title = "TheMovieDB"
        self.searchBar.delegate = self
        
        
    }
    
    func configureTableView(){
        self.isShowLoader()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(UINib.init(nibName: nameCell, bundle: nil), forCellReuseIdentifier: nameCell)
        self.loadMovies()
    }
    
    func loadMovies() {
        self.isShowLoader()
        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.isShowLoader()
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func isShowLoader() {
        if viewModel.showLoader == true {
            self.loaderIndicator.startAnimating()
            self.loaderIndicator.isHidden = false
        } else {
            self.loaderIndicator.stopAnimating()
            self.loaderIndicator.isHidden = true
        }
      }
    
    // Hide the keyboard when scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    // Hide the keyboard when tap on list
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension MovieViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let movie = viewModel.movie(at: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath) as! MovieCell
            cell.layoutIfNeeded()
            cell.configureCell(movie: movie)
            updateCell(indexPath: indexPath)
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          viewModel.didSelectRow(at: indexPath, navigationController: navigationController)
      }

    
    // We do the update to show the scroll placeholder or not without having to scroll first to refresh the view
    func updateCell(indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = self.tableView.cellForRow(at: indexPath) as? MovieCell {
                cell.isShowPlaceholder()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        // We check if the last visible cell is the last one loaded, if it is we get the following page
        if let lastVisibleIndexPath = indexPaths.last,
           lastVisibleIndexPath.row == viewModel.numberOfMovies() - 1 {
            if !self.viewModel.getIsFilterUsed() {
                loadMovies()
            }
        }
    }
}




extension MovieViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
        self.viewModel.searchMovieByTitle(with: searchText)
            self.tableView.reloadData()
        }
       }
}
