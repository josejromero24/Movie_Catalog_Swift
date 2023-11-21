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
        
        
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        
        
        tableView.register(UINib.init(nibName: nameCell, bundle: nil), forCellReuseIdentifier: nameCell)
        
        
        // Llama a la función para cargar las películas
        loadMovies()
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
       
        cell.configureCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        // We check if the last visible cell is the last one loaded, if it is we get the following page
        if let lastVisibleIndexPath = indexPaths.last,
            lastVisibleIndexPath.row == viewModel.numberOfMovies() - 1 {
            loadMovies()
        }
    }
}
