//
//  Movie.swift
//  MovieWatchlist
//
//  Created by Kevin Chen on 8/4/25.
//

import Foundation

/// Represents a single movie object from TMDB's API.
struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?      // poster_path in JSON
    let releaseDate: String?     // release_date in JSON
    /// Local state: whether the user has watched this movie
    var hasWatched: Bool? = nil

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
