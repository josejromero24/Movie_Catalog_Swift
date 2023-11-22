//
//  MovieViewController.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 21/11/23.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
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
        self.configureTableView()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(UINib.init(nibName: nameCell, bundle: nil), forCellReuseIdentifier: nameCell)
        
        self.loadMovies()
    }
    
    func loadMovies() {
        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
            loadMovies()
        }
    }
}
