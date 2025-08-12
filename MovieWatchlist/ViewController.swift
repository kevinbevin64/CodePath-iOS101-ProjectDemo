//
//  ViewController.swift
//  MovieWatchlist
//
//  Created by Kevin Chen on 8/4/25.
//

import UIKit

/// Main view controller for displaying and searching the user's movie watchlist.
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    @IBOutlet weak var movieListView: UITableView!
    
    /// All movies in the user's personal watchlist.
    var movies: [Movie] = []
    /// Results from the TMDB search API.
    var searchResults: [Movie] = []
    /// Search controller for managing the search bar UI and logic.
    let searchController = UISearchController(searchResultsController: nil)
    /// Whether the user is currently viewing search results.
    var isSearching: Bool = false
    /// Whether to show the user's movie list after dismissing the search controller.
    var shouldShowUserListAfterSearch = false
    /// UserDefaults key for persisting the watchlist.
    private let watchlistDefaultsKey = "watchlist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListView.dataSource = self
        movieListView.delegate = self // Adding this fixes issue where search doesn't return to main view
        
        // Set up the title 
        self.title = "Watchlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        movieListView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        // Set up the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.delegate = self

        // Load persisted watchlist and refresh UI
        loadWatchlist()
        movieListView.reloadData()
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        isSearching = true
        searchForMovies(query: query)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchResults = []
        movieListView.reloadData()
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        // No live search; only search when the user taps the Search button.
    }

    // MARK: - TMDB Search API
    /// Searches TMDB for movies matching the given query string.
    private func searchForMovies(query: String) {
        let apiKey = "4f0827225c253953a0af7c0e89135e5e"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery)"
        guard let url = URL(string: urlString) else {
            print("🚨 Invalid URL string: \(urlString)")
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let session = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("🚨 Request failed: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("🚨 Server Error: response: \(String(describing: response))")
                return
            }
            guard let data = data else {
                print("🚨 No data returned from request")
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let movieFeed = try decoder.decode(MovieFeed.self, from: data)
                let results = movieFeed.results
                DispatchQueue.main.async {
                    self?.searchResults = results
                    self?.movieListView.reloadData()
                }
            } catch {
                print("🚨 Error decoding JSON data into MovieFeed: \(error.localizedDescription)")
                return
            }
        }
        session.resume()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchResults.count : movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = isSearching ? searchResults[indexPath.row] : movies[indexPath.row]
        cell.textLabel?.text = movie.title

        if isSearching {
            // While displaying search results, do not show watched state UI.
            cell.accessoryView = nil
            cell.accessoryType = .none
            cell.selectionStyle = .default
        } else {
            // In the watchlist, show a checkmark to indicate watched state. Tap to toggle in didSelectRowAt.
            cell.accessoryView = nil
            cell.selectionStyle = .default
            let isWatched = (movies[indexPath.row].hasWatched ?? false)
            cell.accessoryType = isWatched ? .checkmark : .none
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            print("Search result tapped at row: \(indexPath.row)")
            let selectedMovie = searchResults[indexPath.row]
            if !movies.contains(where: { $0.id == selectedMovie.id }) {
                movies.append(selectedMovie)
                saveWatchlist()
            }
            shouldShowUserListAfterSearch = true
            tableView.deselectRow(at: indexPath, animated: true)
            searchController.isActive = false
            DispatchQueue.main.async { [weak self] in
                self?.isSearching = false
                self?.searchResults = []
                self?.movieListView.reloadData()
            }
        } else {
            // Toggle watched state and refresh the tapped row.
            let current = movies[indexPath.row].hasWatched ?? false
            movies[indexPath.row].hasWatched = !current
            saveWatchlist()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // MARK: - UISearchControllerDelegate
    func didDismissSearchController(_ searchController: UISearchController) {
        if shouldShowUserListAfterSearch {
            isSearching = false
            searchResults = []
            movieListView.reloadData()
            shouldShowUserListAfterSearch = false
        }
    }

    // MARK: - Persistence
    private func saveWatchlist() {
        do {
            let data = try JSONEncoder().encode(movies)
            UserDefaults.standard.set(data, forKey: watchlistDefaultsKey)
        } catch {
            print("Failed to encode movies for persistence: \(error)")
        }
    }

    private func loadWatchlist() {
        guard let data = UserDefaults.standard.data(forKey: watchlistDefaultsKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([Movie].self, from: data)
            movies = decoded
        } catch {
            print("Failed to decode movies from persistence: \(error)")
        }
    }
}

